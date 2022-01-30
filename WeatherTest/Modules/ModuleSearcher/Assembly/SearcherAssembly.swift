//
//  SearcherAssembly.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import UIKit

class SearcherAssembly {
    static func configSearcherModule(output: ModuleOuput?) -> UIViewController? {
        guard let controller = R.storyboard.main.searcherViewController() else { return nil }
        
        let presenter = SearcherPresenterImp()
        let interactor = SearcherInteractorImp()
        let router = SearcherRouterImp()
        
        let weatherDataService = WeatherDataServiceImp()
        let locationService = LocationServiceImp()
        let storageService = SharedStorageImp()
        let backgroudConfigService = BackgroudViewServiceImp()
        let weatherService = WeatherDataServiceImp()
        let dateFormatter = DateFormatterServiceImp()
        let aletService = AlertNotificationServiceImp()
        let coreDataService = CoreDataServiceImp()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = controller
        presenter.output = output
        
        interactor.output = presenter
        interactor.weatherDataService = weatherDataService
        interactor.locationService = locationService
        interactor.storageService = storageService
        interactor.backgroudConfigService = backgroudConfigService
        interactor.weatherService = weatherService
        interactor.dateFormatter = dateFormatter
        interactor.coreDataService = coreDataService
        
        controller.presenter = presenter
        controller.alertService = aletService
        router.view = controller
        
        return controller
    }
}
