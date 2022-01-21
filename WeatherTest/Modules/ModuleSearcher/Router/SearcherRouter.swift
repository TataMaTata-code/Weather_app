//
//  SearcherRouter.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import UIKit

protocol SearcherRouterInput {
    func dismissSearcher(output: ModuleOuput?)
}

final class SearcherRouterImp: SearcherRouterInput {
    weak var view: UIViewController?
    
    func dismissSearcher(output: ModuleOuput?) {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
