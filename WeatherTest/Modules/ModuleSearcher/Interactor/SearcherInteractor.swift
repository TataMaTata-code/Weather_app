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
    func configEntity()
}

protocol SearcherInteractorOuput: AnyObject {
    func updateModel(with model: WeatherModel)
    func updateEntity(with entity: SearcherEntity)
    func updateBackgroud(fileName: String, color: String)
}

final class SearcherInteractorImp: SearcherInteractorInput {
    var output: SearcherInteractorOuput?
    
    var weatherDataService: WeatherDataService!
    var locationService: LocationService!
    var storageService: SharedStorage!
    var backgroudConfigService: BackgroudViewService = BackgroudViewServiceImp()

    func didChooseCityFromSearcher(city: String) {
        locationService.geoCodingAddress(city: city) { [weak self] location in
            self?.locationService.geoCodingCoordinates(currentLocation: location) { [weak self] city, lat, long in
                let model = WeatherModel(city: city, lat: lat, long: long)
                self?.output?.updateModel(with: model)
            }
        }
    }
    private func getEntity() -> MainEntity? {
        let newData = storageService.getValue(key: StorageKey.keyForWeatherForecast)
        guard let entity = try? JSONDecoder().decode(MainEntity.self, from: newData) else { return nil }
        return entity
    }
    
    func configEntity() {
        guard let entity = getEntity() else { return }
        let city = entity.city
        let descript = entity.descript
        let temp = entity.temp
        let feelsLike = entity.feelsLike
        let newEntity = SearcherEntity(city: city,
                                       descript: descript,
                                       temp: temp,
                                       feelsLike: feelsLike,
                                       currentTime: " ")
        output?.updateEntity(with: newEntity)
        output?.updateBackgroud(fileName: backgroudConfigService.backgroudAnimation(entity: entity), color: backgroudConfigService.backgroudColor(entity: entity))
    }
}
