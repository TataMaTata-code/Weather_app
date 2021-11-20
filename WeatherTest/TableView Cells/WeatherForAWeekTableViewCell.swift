//
//  WeatherForAWeekTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit
import CoreLocation

class WeatherForAWeekTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherForAWeekTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: DailyWeatherResponse?
    
    var reloadData: (()->())?
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var lat = CLLocationDegrees()
    var long = CLLocationDegrees()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configCollectionView()
        loadWeatherForecast()
        configLocation()
        //        reloadData()
    }
    
    private func configCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray2
        collectionView.layer.cornerRadius = 15
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherForAWeekTableViewCell", bundle: nil)
    }
    
//MARK: - Setup cell
    
    private func setupTempText(indexPath: IndexPath) -> String {
        let temp = " \(Int(model?.daily[indexPath.item].temp.day ?? 0))°"
        return temp
    }
    
    private func setupIcon(indexPath: IndexPath) -> UIImage? {
        let imgName = UIImage(named: "\(model?.daily[indexPath.item].weather.first?.icon ?? "")")
        return imgName
    }
    
//MARK: - Date Formater
    
    private func dateFormater(indexPath: IndexPath) -> String {
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(model?.daily[indexPath.row].dt ?? 0))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "E"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        print(dateString)
        return dateString
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
                let mapped = try JSONDecoder().decode(DailyWeatherResponse.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.model = mapped
                    self?.collectionView.reloadData()
                    print(mapped)
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    private func prepareLoadDataRequest() -> URL? {
        var components = URLComponents(string: Constants.DailyWeatherForecast.baseUrl)
        components?.queryItems = [URLQueryItem(name: Parameters.lat, value: String(lat)),
                                  URLQueryItem(name: Parameters.lon, value: String(long)),
                                  URLQueryItem(name: Parameters.exclude, value: Parameters.alert),
                                  URLQueryItem(name: Parameters.units, value: Parameters.metric),
                                  URLQueryItem(name: Parameters.appid, value: Constants.DailyWeatherForecast.apiKey)]
        return components?.url
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
        
        print(lat)
        print(long)
        
    }
}

extension WeatherForAWeekTableViewCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty, currentLocation == nil  {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
}

//MARK: - Data source

extension WeatherForAWeekTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.daily.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier, for: indexPath) as? WeekCollectionViewCell else { return UICollectionViewCell() }
        cell.configText()
        cell.backgroundColor = .brown
        cell.addCornerRadius(contentView: cell, cornerRadius: 15, borderWidth: 0.1, color: .lightGray)
        cell.temperature.text = setupTempText(indexPath: indexPath)
        cell.iconWeather.image = setupIcon(indexPath: indexPath)
        cell.dayOfWeek.text = dateFormater(indexPath: indexPath)
        return cell
    }
}
//MARK: - Flow layout

extension WeatherForAWeekTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: contentView.frame.width / 3, height: collectionView.frame.height - 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}

