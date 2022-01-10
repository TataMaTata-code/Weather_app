//
//  SceneDelegate.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let controller = MainAssembly.configMainModule()
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        self.window = window
    }
}

