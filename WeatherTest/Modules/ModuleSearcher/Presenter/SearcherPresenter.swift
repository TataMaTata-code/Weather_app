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
}

protocol SearcherPresenterOuput: AnyObject {
}

final class SearcherPresenterImp: SearcherPresenterInput {
    weak var view: SearcherPresenterOuput?
    var interactor: SearcherInteractorInput!
    var router: SearcherRouterInput!
    weak var ouput: ModuleOuput?
    
    func didChooseCity(city: String) {
        interactor.didChooseCityFromSearcher(city: city)
    }
    func dismissSearcher() {
        router.dismissSearcher()
    }
}

extension SearcherPresenterImp: SearcherInteractorOuput {
    func updateModel(with model: WeatherModel) {
        ouput?.didUpdateModel(model: model)
    }
}
