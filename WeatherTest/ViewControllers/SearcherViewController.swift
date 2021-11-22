//
//  SearcherViewController.swift
//  WeatherTest
//
//  Created by Tata on 22/11/21.
//

import UIKit

class SearcherViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var searcher: UISearchBar!
    private var city = ""
    
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
        if let controller = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            controller.currentCity = city
            controller.loadWeatherForecast()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    @IBAction func goBackToMain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: false)
    }
}
