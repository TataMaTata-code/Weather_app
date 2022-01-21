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
    func checkConnection()
}

protocol SearcherInteractorOuput: AnyObject {
    func updateModel(with model: WeatherModel)
    func updateEntity(with entity: SearcherEntity)
    func updateBackgroud(color: String)
}

final class SearcherInteractorImp: SearcherInteractorInput {
    var output: SearcherInteractorOuput?
    
    var weatherDataService: WeatherDataService!
    var locationService: LocationService!
    var storageService: SharedStorage!
    var backgroudConfigService: BackgroudViewService!
    var weatherService: WeatherDataService!
    var dateFormatter: DateFormatterService!
    
    private var isConnected = false
    
    func didChooseCityFromSearcher(city: String) {
        locationService.geoCodingAddress(city: city) { [weak self] location in
            self?.locationService.geoCodingCoordinates(currentLocation: location) { [weak self] city, lat, long in
                let model = WeatherModel(city: city, lat: lat, long: long)
                self?.output?.updateModel(with: model)
            }
        }
    }
    //    MARK: - UserDefaults
    
    private func getModel() -> WeatherModel? {
        let newData = storageService.getValue(key: StorageKey.keyForWeatherModel)
        guard let model = try? JSONDecoder().decode(WeatherModel.self, from: newData) else { return nil }
        return model
    }
    
    private func saveEntity(with entity: SearcherEntity) {
        let data = try? JSONEncoder().encode(entity)
        storageService.setValue(key: StorageKey.keyForSearcherEntity, value: data)
    }
    
    private func getEntity() -> SearcherEntity? {
        let newData = storageService.getValue(key: StorageKey.keyForSearcherEntity)
        let entity = try? JSONDecoder().decode(SearcherEntity.self, from: newData)
        return entity
    }
    
    func loadWeather() {
        guard let model = getModel() else { return }
        weatherService.loadWeatherData(lat: model.lat, long: model.long) { [weak self] mapped in
            self?.configEntity(with: model, mapped: mapped)
            self?.isConnected = true
        }
    }
    func checkConnection() {
        if !isConnected {
            guard let entity = getEntity() else { return }
            output?.updateEntity(with: entity)
            output?.updateBackgroud(color: backgroudConfigService.backgroudColorSearcher(entity: entity))
        }
    }
    
    private func configEntity(with model: WeatherModel, mapped: WeatherResponse) {
        let icon = mapped.current.weather.first?.icon ?? ""
        let city = model.city
        let descript = mapped.current.weather.first?.description ?? ""
        let temp = "\(Int(mapped.current.temp))°"
        let feelsLike = "Feels like: \(Int(mapped.current.feels_like))°"
        let dt = mapped.current.dt
        let currentTime = dateFormatter.dateFormater(dt: dt, format: "HH:mm")
        let entity = SearcherEntity(icon: icon,
                                    city: city,
                                    descript: descript,
                                    temp: temp,
                                    feelsLike: feelsLike,
                                    currentTime: currentTime)
        output?.updateEntity(with: entity)
        output?.updateBackgroud(color: backgroudConfigService.backgroudColorSearcher(entity: entity))
        saveEntity(with: entity)
    }
}
