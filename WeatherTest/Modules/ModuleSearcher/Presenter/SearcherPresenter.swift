//
//  SearcherPresenter.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import Foundation

protocol SearcherPresenterInput {
    var view: SearcherPresenterOuput? { get set }
    
    func viewIsReady()
    func didChooseCity(city: String)
    func dismissSearcher()
    func updateModelFromView(city: String, lat: Double, long: Double)
    func removeEntityAtIndex(index: Int)
}

protocol SearcherPresenterOuput: AnyObject {
    func setStateWithEntity(with entity: SearcherEntity)
    func setStateWithEntities(with entities: [SearcherEntity])
    func changeStatusNetwork(status: Bool)
}

final class SearcherPresenterImp: SearcherPresenterInput {
    
    weak var view: SearcherPresenterOuput?
    var interactor: SearcherInteractorInput!
    var router: SearcherRouterInput!
    weak var output: ModuleOuput?
    
        
    func viewIsReady() {
        interactor.loadWeather()
        interactor.loadWeatherForCells()
    }
    
    func didChooseCity(city: String) {
        interactor.didChooseCityFromSearcher(city: city)
    }

    func dismissSearcher() {
        router.dismissSearcher(output: self)
    }
    func updateModelFromView(city: String, lat: Double, long: Double) {
        interactor.configModel(city: city, lat: lat, long: long)
    }
    func removeEntityAtIndex(index: Int) {
        interactor.removeEntity(index: index)
    }
}

extension SearcherPresenterImp: SearcherInteractorOuput {
    func updateModel(with model: WeatherModel) {
        output?.didUpdateModel(model: model)
    }
    func updateEntity(with entity: SearcherEntity) {
        view?.setStateWithEntity(with: entity)
    }
    func updateArrayOfEntity(with entity: [SearcherEntity]) {
        view?.setStateWithEntities(with: entity)
    }
    func networkConnection(status: Bool) {
        view?.changeStatusNetwork(status: status)
    }
}

extension SearcherPresenterImp: ModuleOuput {
    func didUpdateModel(model: WeatherModel) {
        
    }
}
