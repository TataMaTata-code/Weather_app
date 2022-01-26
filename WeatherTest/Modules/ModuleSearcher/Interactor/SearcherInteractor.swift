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
    func checkConnection()
    func configModel(city: String, lat: Double, long: Double)
    func removeEntity(index: Int)
}

protocol SearcherInteractorOuput: AnyObject {
    func updateModel(with model: WeatherModel)
    func updateEntity(with entity: SearcherEntity)
    func updateArrayOfEntity(with entity: [SearcherEntity])
}

final class SearcherInteractorImp: SearcherInteractorInput {
    weak var output: SearcherInteractorOuput?
    
    var weatherDataService: WeatherDataService!
    var locationService: LocationService!
    var storageService: SharedStorage!
    var backgroudConfigService: BackgroudViewService!
    var weatherService: WeatherDataService!
    var dateFormatter: DateFormatterService!
    
    private var isConnected = false
    
    //MARK: - Configurations
    
    private func configEntity(with city: String, mapped: WeatherResponse) -> SearcherEntity {
        let scene = backgroudConfigService.backgroudAnimationSearcher(with: mapped)
        let color = backgroudConfigService.backgroudColorSearcher(with: mapped)
        let lat = Double(mapped.lat)
        let long = Double(mapped.lon)
        let city = city
        let descript = mapped.current.weather.first?.description ?? ""
        let temp = "\(Int(mapped.current.temp))°"
        let feelsLike = "Feels like: \(Int(mapped.current.feels_like))°"
        let currentTime = dateFormatter.dateFormatter(dt: Int(mapped.current.dt), format: "HH:mm")
        let entity = SearcherEntity(scene: scene,
                                    color: color,
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
        locationService.geoCodingAddress(city: city) { [weak self] location in
            self?.locationService.geoCodingCoordinates(currentLocation: location) { [weak self] city, lat, long in
                self?.weatherDataService.loadWeatherData(lat: lat, long: long) { [weak self] mapped in
                    self?.updateWeatherCell(with: city, mapped: mapped)
                    self?.getEntitiesFromStorage()
                }
            }
        }
    }
    
    func loadWeather() {
        guard let model = getModel() else { return }
        weatherService.loadWeatherData(lat: model.lat, long: model.long) { [weak self] mapped in
            self?.updateLocationWeatherCell(with: model.city, mapped: mapped)
            self?.isConnected = true
        }
    }
    func loadWeatherForCells() {
        loadCitiesWeather()
    }
    
    private func loadCitiesWeather() {
        let group = DispatchGroup()
        let entities = getEntities()
        var newEntities: [SearcherEntity] = []
        for entity in entities {
            group.enter()
            weatherDataService.loadWeatherData(lat: entity.lat, long: entity.long) { [weak self] mapped in
                guard let newEntity = self?.configEntity(with: entity.city, mapped: mapped) else { return }
                newEntities.append(newEntity)
                self?.saveArrayOfEntities(with: newEntities)
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
    
    func checkConnection() {
        if !isConnected {
            guard let entity = getEntity() else { return }
            output?.updateEntity(with: entity)
        }
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
