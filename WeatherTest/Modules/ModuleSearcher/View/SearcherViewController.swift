//
//  SearcherViewController.swift
//  WeatherTest
//
//  Created by Tata on 22/11/21.
//

import UIKit
import CoreLocation

class SearcherViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    @IBOutlet weak var searcher: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearcherPresenterInput!
    private var searcherEntity: SearcherEntity?
    
    private var isReloaded = false
    
    private var entities: [SearcherEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        config()
    }
    
    //    MARK: - Configurations
    
    private func config() {
        configSuperView()
        configSearcher()
        configTableView()
    }
    
    private func configSuperView() {
        view.blurView(style: .regular)
    }
    
    private func configSearcher() {
        searcher.delegate = self
        
        searcher.backgroundColor = .clear
    }
    
    func configTableView() {
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CurrentLocationTableViewCell.nib(), forCellReuseIdentifier: CurrentLocationTableViewCell.identifier)
    }
    private func reloadTableView() {
        UIView.transition(with: tableView,
                          duration: 0.3,
                          options: .transitionCrossDissolve) {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Searcher
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var city = ""
        searchBar.resignFirstResponder()
        city = searchBar.text ?? ""
        presenter.didChooseCity(city: city)
        searchBar.text = ""
        isReloaded = false
    }
}
//MARK: - TableView DataSource

extension SearcherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentLocationTableViewCell.identifier, for: indexPath) as? CurrentLocationTableViewCell else { return UITableViewCell() }
            guard let fileName = searcherEntity?.scene else { return UITableViewCell() }
            guard let color = searcherEntity?.color else { return UITableViewCell() }
            
            let lat = searcherEntity?.lat ?? 0
            let long = searcherEntity?.long ?? 0
            let city = searcherEntity?.city ?? ""
            
            cell.configBackground(fileName: fileName, color: color)
            cell.locationLabel.text = "Current location"
            cell.cityNameOrTimeLabel.text = searcherEntity?.city
            cell.temperatureLabel.text = searcherEntity?.temp
            cell.descriptionLabel.text = searcherEntity?.descript
            cell.feelsLikeLabel.text = searcherEntity?.feelsLike
            cell.didSelectedRow = { [weak self] in
                self?.presenter.updateModelFromView(city: city, lat: lat, long: long)
                self?.presenter.dismissSearcher()
            }
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentLocationTableViewCell.identifier, for: indexPath) as? CurrentLocationTableViewCell else { return UITableViewCell() }
            cell.alpha = 0
            let entity = entities[indexPath.row - 1]
            
            let fileName = entity.scene
            let color = entity.color
            
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveEaseOut) {
                cell.alpha = 1
            }
            
            cell.configBackground(fileName: fileName, color: color)
            cell.locationLabel.text = entity.city
            cell.cityNameOrTimeLabel.text = entity.currentTime
            cell.descriptionLabel.text = entity.descript
            cell.temperatureLabel.text = entity.temp
            cell.feelsLikeLabel.text = entity.feelsLike
            cell.didSelectedRow = { [weak self] in
                self?.presenter.updateModelFromView(city: entity.city, lat: entity.lat, long: entity.long)
                self?.presenter.dismissSearcher()
            }
            return cell
        }
    }
}

//MARK: - TableView Delegate

extension SearcherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .none
        } else {
            return .delete
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row - 1
        if editingStyle == .delete {
            isReloaded = true
            entities.remove(at: index)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            presenter.removeEntityAtIndex(index: index)
        }
    }
}

//MARK: - Presenter

extension SearcherViewController: SearcherPresenterOuput {
    func setStateWithEntity(with entity: SearcherEntity) {
        searcherEntity = entity
    }
    func setStateWithEntities(with entities: [SearcherEntity]) {
        self.entities = entities
        if !isReloaded {
            reloadTableView()
        }
    }
}


