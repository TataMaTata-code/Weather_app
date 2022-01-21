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
    
    private var city = ""
    private var fileName = ""
    private var color = ""
    
    var presenter: SearcherPresenterInput!
    
    var entity: SearcherEntity?
    
    let dataService = DataService()
    
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
        
        tableView.dataSource = self
        
        tableView.register(CurrentLocationTableViewCell.nib(), forCellReuseIdentifier: CurrentLocationTableViewCell.identifier)
    }
    
    
//MARK: - Searcher
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        city = searchBar.text ?? ""
        presenter.didChooseCity(city: city)
        presenter.dismissSearcher()
    }
}
//MARK: - TableView DataSource

extension SearcherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentLocationTableViewCell.identifier, for: indexPath) as? CurrentLocationTableViewCell else { return UITableViewCell() }
//            cell.configBackgroud(fileName: fileName, color: color)
            cell.cityNameLabel.text = entity?.city
            cell.temperatureLabel.text = entity?.temp
            cell.descriptionLabel.text = entity?.descript
            cell.feelsLikeLabel.text = entity?.feelsLike
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension SearcherViewController: SearcherPresenterOuput {
    func setStateWithEntity(with entity: SearcherEntity) {
        self.entity = entity
    }
    func setBackgroud(fileName: String, color: String) {
        self.fileName = fileName
        self.color = color
    }
}


