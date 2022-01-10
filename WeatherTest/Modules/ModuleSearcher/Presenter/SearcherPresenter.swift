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
    func updateModel(with model: WeatherModel)
}

final class SearcherPresenterImp: SearcherPresenterInput, ModuleInput {
    internal var model: WeatherModel?
    
    weak var view: SearcherPresenterOuput?
    var interactor: SearcherInteractorInput!
    var router: SearcherRouterInput!
    weak var ouput: ModuleOuput?
    
    func didChooseCity(city: String) {
        interactor.didChooseCityFromSearcher(city: city)
    }
    func dismissSearcher() {
        router.dismissSearcher(ouput: self)
    }
}

extension SearcherPresenterImp: SearcherInteractorOuput {
    func updateModel(with model: WeatherModel) {
        view?.updateModel(with: model)
        ouput?.didUpdateModel(model: model)
        print(model.city)
    }
}
extension SearcherPresenterImp: ModuleOuput {
    func didUpdateModel(model: WeatherModel) {
    }
}
