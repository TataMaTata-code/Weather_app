//
//  MainRouter.swift
//  WeatherTest
//
//  Created by Tata on 08/01/22.
//

import UIKit

protocol MainRouterInput {
    func showSearcherScreen()
}

//MARK: - Implementation

final class MainRouterImp: MainRouterInput {
    weak var view: UIViewController?
    
    func showSearcherScreen() {
        guard let view = view, let controller = SearcherAssembly.configSearcherModule() else { return }
        view.navigationController?.pushViewController(controller, animated: true)
    }
}
