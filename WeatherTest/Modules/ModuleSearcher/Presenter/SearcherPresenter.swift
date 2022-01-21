//
//  SearcherPresenter.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

protocol SearcherPresenterInput {
    var view: SearcherPresenterOuput? { get set }
    func didChooseCity(city: String)
    func dismissSearcher()
    func viewIsReady()
}

protocol SearcherPresenterOuput: AnyObject {
    func setStateWithEntity(with entity: SearcherEntity)
    func setBackgroud(color: String)
}

final class SearcherPresenterImp: SearcherPresenterInput {
    
    weak var view: SearcherPresenterOuput?
    var interactor: SearcherInteractorInput!
    var router: SearcherRouterInput!
    weak var output: ModuleOuput?
    
        
    func viewIsReady() {
        interactor.loadWeather()
        interactor.checkConnection()
    }
    
    func didChooseCity(city: String) {
        interactor.didChooseCityFromSearcher(city: city)
    }
    func dismissSearcher() {
        router.dismissSearcher(output: self)
    }
}

extension SearcherPresenterImp: SearcherInteractorOuput {
    func updateModel(with model: WeatherModel) {
        output?.didUpdateModel(model: model)
    }
    func updateEntity(with entity: SearcherEntity) {
        view?.setStateWithEntity(with: entity)
    }
    func updateBackgroud(color: String) {
        view?.setBackgroud(color: color)
    }
}

extension SearcherPresenterImp: DataServiceDelegate {
    func updateEntity(with entity: MainEntity) {
//        view?.setStateWithEntity(with: entity)
    }
}

extension SearcherPresenterImp: ModuleOuput {
    func didUpdateModel(model: WeatherModel) {
        
    }
}
