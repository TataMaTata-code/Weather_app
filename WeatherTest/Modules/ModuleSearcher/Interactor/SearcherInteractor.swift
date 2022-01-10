//
//  SearcherInteractor.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//
import CoreLocation

protocol SearcherInteractorInput {
    var ouput: SearcherInteractorOuput? { get set }
    func didChooseCityFromSearcher(city: String)
}

protocol SearcherInteractorOuput: AnyObject {
    func updateModel(with model: WeatherModel)
}

final class SearcherInteractorImp: SearcherInteractorInput {
    weak var ouput: SearcherInteractorOuput?
    
    var weatherDataService: WeatherDataService = WeatherDataServiceImp()
    var locationService: LocationService = LocationServiceImp()
    
    func didChooseCityFromSearcher(city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { [weak self] coordinate, error in
            DispatchQueue.main.async { [weak self] in
                guard let location = coordinate?.first?.location else { return }
                self?.locationService.geoCodingCoordinates(currentLocation: location) { [weak self] city, lat, long in
                    let model = WeatherModel(city: city, lat: lat, long: long)
                    self?.ouput?.updateModel(with: model)
                }
            }
        }
    }
}
