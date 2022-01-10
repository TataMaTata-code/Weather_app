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
    private var city = ""
    
    var presenter: SearcherPresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searcher.delegate = self
        
    }
    func updateSearchResults(for searchController: UISearchController) {
//        city = searchController.searchBar.text ?? ""

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        city = searchBar.text ?? ""
        presenter.didChooseCity(city: city)
        presenter.dismissSearcher()
    }
}

extension SearcherViewController: SearcherPresenterOuput {
    func updateModel(with model: WeatherModel) {
        
    }
}
