//
//  SearcherInteractor.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//
import CoreLocation

protocol SearcherInteractorInput {
    var output: SearcherInteractorOuput? { get set }
    
    func didChooseCityFromSearcher(city: String)
    func loadWeather()
    func loadWeatherForCells()
    func configModel(city: String, lat: Double, long: Double)
    func removeEntity(index: Int)
}

protocol SearcherInteractorOuput: AnyObject {
    func updateModel(with model: WeatherModel)
    func updateEntity(with entity: SearcherEntity)
    func updateArrayOfEntity(with entity: [SearcherEntity])
    func networkConnection(status: Bool)
}

final class SearcherInteractorImp: SearcherInteractorInput {
    weak var output: SearcherInteractorOuput?
    
    var weatherDataService: WeatherDataService!
    var locationService: LocationService!
    var storageService: SharedStorage!
    var backgroudConfigService: BackgroudViewService!
    var weatherService: WeatherDataService!
    var dateFormatter: DateFormatterService!
    var coreDataService: CoreDataService!
    
    private var isConnected = false
    
    //MARK: - Configurations
    
    private func configEntity(with city: String, mapped: WeatherResponse) -> SearcherEntity {
        let dt = mapped.current.dt
        let timeZoneOffset = Int(mapped.timezone_offset)
        let currentTime = dateFormatter.dateFormatterWithTimeZone(format: "HH:mm", dt: dt, offset: timeZoneOffset)
        
        let lat = Double(mapped.lat)
        let long = Double(mapped.lon)
        let city = city
        let descript = mapped.current.weather.first?.description ?? ""
        let temp = "\(Int(mapped.current.temp))°"
        let feelsLike = "Feels like: \(Int(mapped.current.feels_like))°"
        let entity = SearcherEntity(background: backgroudConfigService.backgroundConfigWithModel(with: mapped),
                                    lat: lat,
                                    long: long,
                                    city: city,
                                    descript: descript,
                                    temp: temp,
                                    feelsLike: feelsLike,
                                    currentTime: currentTime)
        return entity
    }
    
    func configModel(city: String, lat: Double, long: Double) {
        let model = WeatherModel(city: city, lat: lat, long: long)
        output?.updateModel(with: model)
    }
    
    //MARK: - API Responses
    
    func didChooseCityFromSearcher(city: String) {
        locationService.geoCodingAddress(city: city) { [weak self] location, error in
            if error == nil {
                guard let location = location else { return }
                self?.locationService.geoCodingCoordinates(currentLocation: location) { [weak self] city, lat, long, error in
                    self?.weatherDataService.loadWeatherData(lat: lat ?? 0, long: long ?? 0) { [weak self] mapped, error in
                        if mapped != nil {
                            guard let mapped = mapped else { return }
                            self?.updateWeatherCell(with: city ?? "", mapped: mapped)
                            self?.getEntitiesFromStorage()
                        } else {
                            print("Error: \(String(describing: error))")
                        }
                    }
                }
            } else {
                self?.output?.networkConnection(status: false)
            }
        }
    }
    func loadWeather() {
        guard let model = getModel() else { return }
        weatherService.loadWeatherData(lat: model.lat, long: model.long) { [weak self] mapped, error  in
            if let newMapped = mapped {
                self?.updateLocationWeatherCell(with: model.city, mapped: newMapped)
            } else {
                self?.getCurrentCityEntityFromStorage()
                print("Error: \(String(describing: error))")
            }
        }
        self.getCurrentCityEntityFromStorage()
    }
    
    func loadWeatherForCells() {
        loadCitiesWeather()
    }
    
    private func loadCitiesWeather() {
        let group = DispatchGroup()
        var entities = getEntities()
        for i in 0..<entities.count {
            group.enter()
            weatherService.loadWeatherData(lat: entities[i].lat, long: entities[i].long) { [weak self] mapped, error in
                if mapped != nil {
                    guard let mapped = mapped else { return }
                    guard let newEntity = self?.configEntity(with: entities[i].city, mapped: mapped) else { return }
                    entities[i] = newEntity
                    self?.saveArrayOfEntities(with: entities)
                } else {
                    self?.getEntitiesFromStorage()
                    print("Error: \(String(describing: error))")
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.getEntitiesFromStorage()
        }
    }
    
    //MARK: - UpdatingCells
    
    private func updateLocationWeatherCell(with city: String, mapped: WeatherResponse) {
        let entity = configEntity(with: city, mapped: mapped)
        output?.updateEntity(with: entity)
        saveEntity(with: entity)
    }
    private func updateWeatherCell(with city: String, mapped: WeatherResponse) {
        let entity = configEntity(with: city, mapped: mapped)
        saveEntityAtArray(with: entity)
    }
    
    //MARK: - Entity
    
    private func getEntitiesFromStorage() {
        let entities = getEntities()
        output?.updateArrayOfEntity(with: entities)
    }
    
    func removeEntity(index: Int) {
        var entities = getEntities()
        entities.remove(at: index)
        saveArrayOfEntities(with: entities)
        getEntitiesFromStorage()
    }
    
    private func getCurrentCityEntityFromStorage() {
        guard let entity = getEntity() else { return }
        output?.updateEntity(with: entity)
    }
    
    //MARK: - EntityStorage
    
    private func saveEntity(with entity: SearcherEntity) {
        let data = try? JSONEncoder().encode(entity)
        storageService.setValue(key: StorageKey.keyForSearcherEntity, value: data)
    }
    
    private func getEntity() -> SearcherEntity? {
        let newData = storageService.getValue(key: StorageKey.keyForSearcherEntity)
        let entity = try? JSONDecoder().decode(SearcherEntity.self, from: newData)
        return entity
    }
    
    //MARK: - EntitiesStorage
    
    private func saveEntityAtArray(with entity: SearcherEntity) {
        var entities = getEntities()
        entities.append(entity)
        let data = try? JSONEncoder().encode(entities)
        storageService.setValue(key: StorageKey.keyForSearcherEntities, value: data)
    }
    
    private func saveArrayOfEntities(with entities: [SearcherEntity]) {
        let data = try? JSONEncoder().encode(entities)
        storageService.setValue(key: StorageKey.keyForSearcherEntities, value: data)
    }
    
    private func getEntities() -> [SearcherEntity] {
        let newData = storageService.getValue(key: StorageKey.keyForSearcherEntities)
        let entities = try? JSONDecoder().decode([SearcherEntity].self, from: newData)
        return entities ?? []
    }
    
    //MARK: - ModelsStorage
    
    private func getModel() -> WeatherModel? {
        let newData = storageService.getValue(key: StorageKey.keyForWeatherModel)
        guard let model = try? JSONDecoder().decode(WeatherModel.self, from: newData) else { return nil }
        return model
    }
}
