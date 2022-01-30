//
//  MainAssembly.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import UIKit
import SpriteKit
import Rswift

class MainAssembly {
    static func configMainModule() -> UIViewController? {
        guard let controller = R.storyboard.main.mainViewController() else { return nil }
        
        let presenter = MainPresenterImp()
        let interactor = MainInteractorImp()
        let router = MainRouterImp()
        
        let locationService = LocationServiceImp()
        let weatherService = WeatherDataServiceImp()
        let storageService = SharedStorageImp()
        let dateFormatterService = DateFormatterServiceImp()
        let backgroudViewService = BackgroudViewServiceImp()
        let alertService = AlertNotificationServiceImp()
        let coreDataService = CoreDataServiceImp()
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = controller
        
        interactor.output = presenter
        
        interactor.locationService = locationService
        interactor.weatherService = weatherService
        interactor.storageService = storageService
        interactor.dateFormatterService = dateFormatterService
        interactor.backgroudConfigService = backgroudViewService
        interactor.coreDataService = coreDataService
        
        controller.presenter = presenter
        controller.dateFormatterService = dateFormatterService
        controller.alertService = alertService

        router.view = controller
        
        return controller
    }
}
