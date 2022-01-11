//
//  MainAssembly.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import UIKit

class MainAssembly {
    static func configMainModule() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return nil }
        
        let navigationView = UINavigationController(rootViewController: controller)
        navigationView.isNavigationBarHidden = true
        
        let presenter = MainPresenterImp()
        let interactor = MainInteractorImp()
        let router = MainRouterImp()
        
        let locationService = LocationServiceImp()
        let weatherService = WeatherDataServiceImp()
        let storageService = SharedStorageImp()
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = controller
        
        interactor.output = presenter
        interactor.locationService = locationService
        interactor.weatherService = weatherService
        interactor.storageService = storageService
        
        router.view = controller
        controller.presenter = presenter
        
        return navigationView
    }
}
