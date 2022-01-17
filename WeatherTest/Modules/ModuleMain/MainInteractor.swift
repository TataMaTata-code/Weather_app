//
//  MainInteracotr.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//


import CoreLocation

protocol MainInteractorInput {
    var output: MainInteractorOuput? { get set }
    func locationAccess()
    func checkConnection()
    func loadWeatherForecast(with model: WeatherModel)
}

protocol MainInteractorOuput: AnyObject {
    func updateEntity(entity: MainEntity)
    func updateBackgroud(fileName: String, color: String)
}

//MARK: - Implementation

final class MainInteractorImp: NSObject, MainInteractorInput {
    weak var output: MainInteractorOuput?
    
    var locationService: LocationService!
    var weatherService: WeatherDataService!
    var storageService: SharedStorage!
    var dateFormatterService: DateFormatterService!
    var backgroudConfigService: BackgroudViewService!
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    var entity: MainEntity?
        
    var isConnected = false
    
    func locationAccess() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func configEntity(with mapped: WeatherResponse, model: WeatherModel) {
        let city = model.city
        let icon = mapped.current.weather.first?.icon ?? ""
        let temp = "\(Int(mapped.current.temp))°"
        let wind = " : \(Int(mapped.current.wind_speed)) m/s"
        let humidity = " : \(Int(mapped.current.humidity))%"
        let descript = mapped.current.weather.first?.main ?? ""
        let sunrise = dateFormatterService.dateFormater(dt: mapped.current.sunrise, format: " HH:mm")
        let sunset = dateFormatterService.dateFormater(dt: mapped.current.sunset, format: " HH:mm")
        let entity = MainEntity(city: city,
                                icon: icon,
                                temp: temp,
                                descript: descript,
                                humidity: humidity,
                                wind: wind,
                                sunrise: sunrise,
                                sunset: sunset,
                                hourly: mapped.hourly,
                                daily: mapped.daily)
        if !entity.city.isEmpty {
            saveEntity(entity: entity)
            output?.updateEntity(entity: entity)
            output?.updateBackgroud(fileName: backgroudConfigService.backgroudAnimation(entity: entity),
                                    color: backgroudConfigService.backgroudColor(entity: entity))
        }
    }
    
    func loadWeatherForecast(with model: WeatherModel) {
        weatherService.loadWeatherData(lat: model.lat, long: model.long) { [weak self] mapped in
            self?.configEntity(with: mapped, model: model)
        }
    }
    
    func checkConnection() {
        if isConnected == false {
            guard let entity = getEntity() else { return }
            output?.updateEntity(entity: entity)
            output?.updateBackgroud(fileName: backgroudConfigService.backgroudAnimation(entity: entity),
                                    color: backgroudConfigService.backgroudColor(entity: entity))
        }
    }
    
    private func saveEntity(entity: MainEntity) {
        let data = try? JSONEncoder().encode(entity)
        storageService.setValue(key: StorageKey.keyForWeatherForecast, value: data)
    }
    
    private func getEntity() -> MainEntity? {
        let newData = storageService.getValue(key: StorageKey.keyForWeatherForecast)
        let entity = try? JSONDecoder().decode(MainEntity.self, from: newData)
        return entity
    }
}

extension MainInteractorImp: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            self.currentLocation = locations.first ?? CLLocation()
            self.locationManager.stopUpdatingLocation()
            locationService.geoCodingCoordinates(currentLocation: currentLocation) { [weak self] city, lat, long in
                let newModel = WeatherModel(city: city, lat: lat, long: long)
                self?.loadWeatherForecast(with: newModel)
                self?.isConnected = true
            }
        }
    }
}
