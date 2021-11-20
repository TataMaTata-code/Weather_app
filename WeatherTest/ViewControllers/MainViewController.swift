//
//  MainViewController.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit
import SnapKit
import CoreLocation


class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var lat = CLLocationDegrees()
    var long = CLLocationDegrees()
    
    var model: WeatherResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configLocation()
        
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrentWeatherTableViewCell.nib(), forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier)
        tableView.register(WeatherForAWeekTableViewCell.nib(), forCellReuseIdentifier: WeatherForAWeekTableViewCell.identifier)
    }
    
//MARK: - Location
    
    private func configLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        requestWeatherForLocation()
    }
    
    private func requestWeatherForLocation() {
        
        guard let currentLocation = currentLocation else { return }
        long = currentLocation.coordinate.longitude
        lat = currentLocation.coordinate.latitude
        loadWeatherForecast()

//        print(lat)
//        print(long)
        
    }
    
    //MARK: - API
    
    private func loadWeatherForecast() {
        let session = URLSession.shared
        let request: URLRequest = URLRequest(url: prepareLoadDataRequest()!)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else {
                return
            }
            do {
                let mapped = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.model = mapped
                    self?.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    private func prepareLoadDataRequest() -> URL? {
        var components = URLComponents(string: Constants.CurrentWeatherForecast.baseUrl)
        components?.queryItems = [URLQueryItem(name: Parameters.lat, value: String(lat)),
                                  URLQueryItem(name: Parameters.lon, value: String(long)),
                                  URLQueryItem(name: Parameters.units, value: Parameters.metric),
                                  URLQueryItem(name: Parameters.appid, value: Constants.CurrentWeatherForecast.apiKey)]
        return components?.url
    }
}

//MARK: - Delegate Location

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty, currentLocation == nil  {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
}

//MARK: - Delegate TableView

extension MainViewController: UITableViewDelegate {
    
}

//MARK: - Data Source TableView

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.identifier, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
            let city = model?.name ?? ""
            let temp = " \(Int(model?.main.temp ?? 0))°"
            let descript = model?.weather[indexPath.row].main ?? ""
            let humidity = "Humidity: \(Double(model?.main.humidity ?? 0))%"
            let wind = "Wind: \(Int(model?.wind.speed ?? 0)) m/s"
              cell.backgroundColor = .clear
            cell.setupAllConfig(city: city, temperature: temp, descrip: descript, humidity: humidity, wind: wind)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForAWeekTableViewCell.identifier, for: indexPath) as? WeatherForAWeekTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}
