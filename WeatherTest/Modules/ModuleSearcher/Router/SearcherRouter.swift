//
//  SearcherRouter.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import UIKit

protocol SearcherRouterInput {
    func dismissSearcher(ouput: ModuleOuput)
}

final class SearcherRouterImp: SearcherRouterInput {
    weak var view: UIViewController?
    
    func dismissSearcher(ouput: ModuleOuput) {
        guard let view = view else { return }
        view.navigationController?.popToRootViewController(animated: true)
    }
}
