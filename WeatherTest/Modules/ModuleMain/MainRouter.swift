//
//  MainRouter.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import UIKit

protocol MainRouterInput {
    func showSearcherScreen(ouput: ModuleOuput?)
}

//MARK: - Implementation

final class MainRouterImp: MainRouterInput {
    weak var view: UIViewController?
    
    func showSearcherScreen(ouput: ModuleOuput?) {
        guard let view = view, let controller = SearcherAssembly.configSearcherModule(output: ouput) else { return }
        view.present(controller, animated: true)
    }
}
