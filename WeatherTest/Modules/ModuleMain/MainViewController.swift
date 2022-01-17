//
//  MainViewController.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit
import SpriteKit
import SnapKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    let buttonShowSearcher = UIButton()
    
    var presenter: MainPresenterInput!
    
    var mainEntity: MainEntity?
    let iconsDic = MainIconsEntity()
    
    var dateFormatterService: DateFormatterService!
    var backgroudViewService: BackgroudViewService!
    
    override func loadView() {
        super.loadView()
        prepareView()
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        config()
    }
    
    private func prepareView() {
        let skView = SKView(frame: view.frame)
        view = skView
    }
    
    private func config() {
        configTableView()
        configButton()
    }
    
    private func configBackgroud(fileName: String, color: String) {
        var skView: SKView { view as! SKView }
        let scene = SKScene(size: view.frame.size)
        skView.presentScene(scene)
        
        guard let node = SKSpriteNode(fileNamed: fileName) else { return }
        node.position = CGPoint(x: view.frame.width + 100,
                                y: view.frame.height + 30)
        scene.backgroundColor = UIColor(hex: color) ?? .white
        
        scene.addChild(node)
    }
    
    private func configTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrentWeatherTableViewCell.nib(), forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier)
        tableView.register(WeatherHourlyTableViewCell.nib(), forCellReuseIdentifier: WeatherHourlyTableViewCell.identifier)
        tableView.register(DailyWeatherTableViewCell.nib(), forCellReuseIdentifier: DailyWeatherTableViewCell.indetifier)
    }
    
    private func configButton() {
        let plusIcon = UIImage(systemName: "plus")
        
        view.addSubview(buttonShowSearcher)

        buttonShowSearcher.setBackgroundImage(plusIcon, for: .normal)
        buttonShowSearcher.tintColor = .white
        buttonShowSearcher.addTarget(self, action: #selector(actionShowSearchScreen), for: .touchUpInside)
        
        buttonShowSearcher.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.size.equalTo(25)
            make.right.equalToSuperview().inset(35)
        }
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
    
    
    @objc func actionShowSearchScreen() {
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
            cell.descriptionWeather.text = mainEntity?.descript
            cell.humidityLabel.text = mainEntity?.humidity
            cell.windLabel.text = mainEntity?.wind
            cell.sunriseLabel.text = mainEntity?.sunrise
            cell.sunsetLabel.text = mainEntity?.sunset
            
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
    func setBackgroud(fileName: String, color: String) {
        configBackgroud(fileName: fileName, color: color)
    }
}
