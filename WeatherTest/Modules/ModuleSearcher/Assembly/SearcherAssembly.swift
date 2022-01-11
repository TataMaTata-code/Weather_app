//
//  SearcherAssembly.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import UIKit

class SearcherAssembly {
    static func configSearcherModule(output: ModuleOuput) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SearcherViewController") as? SearcherViewController else { return nil }
        
        let presenter = SearcherPresenterImp()
        let interactor = SearcherInteractorImp()
        let router = SearcherRouterImp()
        let weatherDataService = WeatherDataServiceImp()
        let locationService = LocationServiceImp()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = controller
        presenter.ouput = output
        
        interactor.ouput = presenter
        interactor.weatherDataService = weatherDataService
        interactor.locationService = locationService
        
        router.view = controller
        controller.presenter = presenter
        
        return controller
    }
}
