//
//  WeatherHourlyTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit
import CoreLocation

class WeatherHourlyTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherHourlyTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    var presenter: HourlyWeatherPresenterInput!
        
    private var temp: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configModule()
        presenter.viewIsReady()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
    }
    
    private func configModule() {
        let presenter = HourlyWeatherPresenterImp()
        let interactor = HourlyWeatherInteracorImp()
        let router = HourlyWeatherRouterImp()
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = self
        
        interactor.output = presenter
        router.view = self
        self.presenter = presenter
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherHourlyTableViewCell", bundle: nil)
    }
    
    //MARK: - Setup cell
    
//    private func setupTempText(indexPath: IndexPath) -> String {
//        let temp = "  \(Int(input.model?.list[indexPath.row].main.temp ?? 0))°"
//        return temp
//    }
//
//    private func setupIcon(indexPath: IndexPath) -> UIImage? {
//        let imgName = UIImage(named: "\(input.model?.list[indexPath.row].weather.first?.icon ?? "")")
//        return imgName
//    }
//
//    //MARK: - Date Formater
//
//    private func dateFormater(indexPath: IndexPath) -> String {
//
//        let date = NSDate(timeIntervalSince1970: TimeInterval(input.model?.list[indexPath.row].dt ?? 0))
//
//        let dayTimePeriodFormatter = DateFormatter()
//        dayTimePeriodFormatter.dateFormat = "E, d"
//
//        let dateString = dayTimePeriodFormatter.string(from: date as Date)
//        return dateString
//    }
}
//MARK: - API

//    func loadWeatherForecast() {
//
//        reloadCoordinates?()
//        let session = URLSession.shared
//        let request: URLRequest = URLRequest(url: prepareLoadDataRequest()!)
//        let task = session.dataTask(with: request) { [weak self] data, response, error in
//            guard let data = data else {
//                return
//            }
//            do {
//                let mapped = try JSONDecoder().decode(WeatherResponse.self, from: data)
//                DispatchQueue.main.async { [weak self] in
//                    self?.model = mapped
//                    self?.collectionView.reloadData()
//                }
//            } catch let error {
//                print(error)
//            }
//        }
//        task.resume()
//    }
//
//    private func prepareLoadDataRequest() -> URL? {
//
//        var components = URLComponents(string: Constants.DailyWeatherForecast.baseUrl)
//        components?.queryItems = [URLQueryItem(name: Parameters.q, value: ""),
//                                  URLQueryItem(name: Parameters.units, value: Parameters.metric),
//                                  URLQueryItem(name: Parameters.appid, value: Constants.DailyWeatherForecast.apiKey)]
//        print(components?.url)
//        return components?.url
//
//    }
//}

//MARK: - Data source

extension WeatherHourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(input.model?.list.count, input.currentCity)
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier, for: indexPath) as? WeekCollectionViewCell else { return UICollectionViewCell() }
        
//        cell.configText()
        cell.addCornerRadius(contentView: cell, cornerRadius: 15, borderWidth: 0.1, color: .lightGray)
//        cell.iconWeather.image = setupIcon(indexPath: indexPath)
        cell.temperature.text = temp
//        cell.dayOfWeek.text = dateFormater(indexPath: indexPath)
        cell.backgroundColor = UIColor(hex: "#a7bfe8")
        
        return cell
    }
}
//MARK: - Flow layout

extension WeatherHourlyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: contentView.frame.width / 3.5, height: collectionView.frame.height - 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}

extension WeatherHourlyTableViewCell: HourlyWeatherPresenterOutput {
    func setState(with entity: HourlyWeatherEntity) {
            self.temp = entity.temp
            self.collectionView.reloadData()
    }
}
