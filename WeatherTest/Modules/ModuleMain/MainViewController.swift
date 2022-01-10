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
    
    let dateFormatterService: DateFormatterService = DateFormatterServiceImp()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        configTableView()
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrentWeatherTableViewCell.nib(), forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier)
        tableView.register(WeatherHourlyTableViewCell.nib(), forCellReuseIdentifier: WeatherHourlyTableViewCell.identifier)
        tableView.register(DailyWeatherTableViewCell.nib(), forCellReuseIdentifier: DailyWeatherTableViewCell.indetifier)
    }
    
    private func setDayOfWeek(indexPath: IndexPath) -> String {
        guard let mainEntity = mainEntity else { return "" }
        let date = dateFormatterService.dateFormater(with: mainEntity, indexPath: indexPath)
        return date
    }
    
    private func setIcon(indexPath: IndexPath) -> UIImage? {
        let iconName = mainEntity?.daily[indexPath.row].weather.first?.icon ?? ""
        let icon = UIImage(named: iconName)
        return icon
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
            cell.humidityLabel.text = mainEntity?.humidity
            cell.windLabel.text = mainEntity?.wind
            
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
