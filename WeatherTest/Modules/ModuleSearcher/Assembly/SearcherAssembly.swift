//
//  SearcherAssembly.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import UIKit

class SearcherAssembly {
    static func configSearcherModule(output: ModuleOuput?) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SearcherViewController") as? SearcherViewController else { return nil }
        
        let presenter = SearcherPresenterImp()
        let interactor = SearcherInteractorImp()
        let router = SearcherRouterImp()
        
        let weatherDataService = WeatherDataServiceImp()
        let locationService = LocationServiceImp()
        let storageService = SharedStorageImp()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = controller
        presenter.output = output
        
        interactor.output = presenter
        interactor.weatherDataService = weatherDataService
        interactor.locationService = locationService
        interactor.storageService = storageService
        
        controller.presenter = presenter
        router.view = controller
        
        return controller
    }
}
