//
//  MainPresenter.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import Foundation

protocol MainPresenterInput {
    var view: MainPresenterOutput? { get set }
    func viewIsReady()
    func showSearcherScreen()
}

protocol MainPresenterOutput: AnyObject {
    func setState(with entity: MainEntity)
    func setBackgroud(fileName: String, color: String)
}

//MARK: - Implementation

final class MainPresenterImp: MainPresenterInput, ModuleInput {
    internal var model: WeatherModel?
    
    weak var view: MainPresenterOutput?
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    
    func viewIsReady() {
        interactor.locationAccess()
        interactor.checkConnection()
    }
    
    func showSearcherScreen() {
        router.showSearcherScreen(ouput: self)
    }
}
extension MainPresenterImp: MainInteractorOuput {
    func updateEntity(entity: MainEntity) {
        view?.setState(with: entity)
    }
    func updateBackgroud(fileName: String, color: String) {
        view?.setBackgroud(fileName: fileName, color: color)
    }
}
extension MainPresenterImp: ModuleOuput {
    func didUpdateModel(model: WeatherModel) {
        interactor.loadWeatherForecast(with: model)
    }
}
