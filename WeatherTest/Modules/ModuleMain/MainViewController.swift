//
//  MainViewController.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainPresenterInput!
    
    var mainEntity: MainEntity?
    let iconsDic = MainIconsEntity()
    
    let dateFormatterService: DateFormatterService = DateFormatterServiceImp()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        config()
    }
    
    private func config() {
        gradientView()
        configTableView()
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrentWeatherTableViewCell.nib(), forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier)
        tableView.register(WeatherHourlyTableViewCell.nib(), forCellReuseIdentifier: WeatherHourlyTableViewCell.identifier)
        tableView.register(DailyWeatherTableViewCell.nib(), forCellReuseIdentifier: DailyWeatherTableViewCell.indetifier)
    }
    
    private func gradientView() {
        guard let firstColor = UIColor(hex: "#6190e8") else { return }
        guard let secondColor = UIColor(hex: "#a7bfe8") else { return }
        view.addGradientAxial(firstColor: firstColor, secondColor: secondColor)
        
    }
    
    private func setHourlyCells(cell: WeekCollectionViewCell, indexPath: IndexPath) {
        let dt = mainEntity?.hourly[indexPath.row].dt ?? 0
        let date = dateFormatterService.dateFormater(dt: dt, format: "H")
        let iconName = mainEntity?.hourly[indexPath.row].weather.first?.icon
        
        for icons in iconsDic.iconsDic {
            if iconName == icons.key {
                let icon = UIImage(systemName: icons.value)?.withRenderingMode(.alwaysOriginal)
                cell.iconWeather.image = icon
            }
        }
        cell.hours.text = date
        cell.temperature.text = "\(Int(mainEntity?.hourly[indexPath.row].temp ?? 0))°"
        
    }
    
    private func setDayOfWeek(indexPath: IndexPath) -> String {
        guard let dt = (mainEntity?.daily[indexPath.row].dt) else { return "" }
        let date = dateFormatterService.dateFormater(dt: dt, format: "E")
        return date
    }
    
    private func setIcon(indexPath: IndexPath) -> UIImage? {
        let iconName = mainEntity?.daily[indexPath.row].weather.first?.icon ?? ""
        for icons in iconsDic.iconsDic {
            if iconName == icons.key {
                let icon = UIImage(systemName: icons.value)?.withRenderingMode(.alwaysOriginal)
                return icon
            }
        }
        return UIImage(named: "")
    }
    
    private func setMinTemp(indexPath: IndexPath) -> String {
        let minTemp = "\(Int(mainEntity?.daily[indexPath.row].temp.min ?? 0))°"
        return minTemp
    }
    
    private func setMaxTemp(indexPath: IndexPath) -> String {
        let maxTemp = "\(Int(mainEntity?.daily[indexPath.row].temp.max ?? 0))°"
        return maxTemp
    }
    
//    MARK: - Actions
    
    
    @IBAction func actionShowSearchScreen(_ sender: Any) {
        presenter.showSearcherScreen()
    }
}

//MARK: - Data Source TableView

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainEntity?.daily.count ?? 0
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.identifier, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.cityName.text = mainEntity?.city
            cell.temperatureLabel.text = mainEntity?.temp
            cell.descriptionWeather.text = ""
            cell.humidityLabel.text = mainEntity?.humidity
            cell.windLabel.text = mainEntity?.wind
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHourlyTableViewCell.identifier, for: indexPath) as? WeatherHourlyTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.setTemp = { [weak self] cell, index in
                self?.setHourlyCells(cell: cell, indexPath: index)
            }
            cell.collectionView.reloadData()
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.indetifier, for: indexPath) as? DailyWeatherTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.dayOfWeekLabel.text = setDayOfWeek(indexPath: indexPath)
            cell.iconImageView.image = setIcon(indexPath: indexPath)
            cell.minTempLabel.text = setMinTemp(indexPath: indexPath)
            cell.maxTempLabel.text = setMaxTemp(indexPath: indexPath)
            
            return cell
        }
    }
}
extension MainViewController: MainPresenterOutput {
    func setState(with entity: MainEntity) {
        mainEntity = entity
        tableView.reloadData()
        
    }
}
