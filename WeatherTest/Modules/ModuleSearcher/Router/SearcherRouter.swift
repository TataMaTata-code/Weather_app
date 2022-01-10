//
//  SearcherRouter.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import UIKit

protocol SearcherRouterInput {
    func dismissSearcher()
}

final class SearcherRouterImp: SearcherRouterInput {
    
    weak var view: UIViewController?
    
    func dismissSearcher() {
        guard let view = view else { return }
        view.navigationController?.popToRootViewController(animated: true)
    }
}
