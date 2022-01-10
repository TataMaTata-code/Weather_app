//
//  HourlyWeatherPresenter.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

protocol HourlyWeatherPresenterInput {
    var view: HourlyWeatherPresenterOutput? { get set }
    func viewIsReady()
}
protocol HourlyWeatherPresenterOutput: AnyObject {
    func setState(with entity: HourlyWeatherEntity)

}

//MARK: - Implementation

final class HourlyWeatherPresenterImp: HourlyWeatherPresenterInput {
    weak var view: HourlyWeatherPresenterOutput?
    
    var interactor: HourlyWeatherInteractorInput!
    var router: HourlyWeatherRouterInput!
    
    func viewIsReady() {
        print("ok")
    }
    private func updateState(with entity: HourlyWeatherEntity) {
        view?.setState(with: entity)
    }
}

extension HourlyWeatherPresenterImp: ModuleOuput {
    func didUpdateModel(model: WeatherModel) {
//        interactor.getCityName(with: model)
    }
}

extension HourlyWeatherPresenterImp: HourlyWeatherInteracorOutput {
    func updateEntity(with entity: HourlyWeatherEntity) {
        updateState(with: entity)
    }
}

