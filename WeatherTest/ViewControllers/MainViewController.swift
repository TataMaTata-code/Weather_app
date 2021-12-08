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
    
    var model: WeatherResponse?
    
    var currentCity = ""
    var lat = CLLocationDegrees()
    var long = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLocation()
        configTableView()
        gradientView()
        
    }
    
    private func gradientView() {
        guard let firstColor = UIColor(hex: "#6190e8") else { return }
        guard let secondColor = UIColor(hex: "#a7bfe8") else { return }
        view.addGradientAxial(firstColor: firstColor, secondColor: secondColor)
        
    }
    
    func configTableView() {
        tableView.dataSource = self
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
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placeMark = placemarks?.first else { return }
            if let city = placeMark.subAdministrativeArea {
                if self.currentCity == "" {
                    self.currentCity = city
                    self.loadWeatherForecast()
                }
            }
        }
    }
    
//MARK: - Config cell
    
    private func city(indexPath: IndexPath) -> String {
        let city = model?.name ?? ""
        return city
    }
    
    private func temp(indexPath: IndexPath) -> String {
        let temp = " \(Int(model?.main.temp ?? 0))°"
        return temp
    }
    
    private func descript(indexPath: IndexPath) -> String {
        let descript = model?.weather[indexPath.row].main ?? ""
        return descript
    }
    
    private func humidity(indexPath: IndexPath) -> String {
        let humidity = "Humidity: \(Double(model?.main.humidity ?? 0))%"
        return humidity
    }
    
    private func wind(indexPath: IndexPath) -> String {
        let wind = "Wind: \(Int(model?.wind.speed ?? 0)) m/s"
        return wind
    }
    
//MARK: - API
    
    func loadWeatherForecast() {
        
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
        components?.queryItems = [URLQueryItem(name: Parameters.q, value: currentCity),
                                  URLQueryItem(name: Parameters.units, value: Parameters.metric),
                                  URLQueryItem(name: Parameters.appid, value: Constants.CurrentWeatherForecast.apiKey)]
        return components?.url
    }
//MARK: - Actions
    
    @IBAction func actionAddCity(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "SearcherViewController") as? SearcherViewController {
            navigationController?.pushViewController(controller, animated: true)
        }
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

//MARK: - Data Source TableView

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.identifier, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.setupAllConfig(city: city(indexPath: indexPath),
                                temperature: temp(indexPath: indexPath),
                                descrip: descript(indexPath: indexPath),
                                humidity: humidity(indexPath: indexPath),
                                wind: wind(indexPath: indexPath))
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForAWeekTableViewCell.identifier, for: indexPath) as? WeatherForAWeekTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.reloadCoordinates = { [weak self] in
                cell.city = self?.currentCity ?? ""
            }
            cell.loadWeatherForecast()
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}
