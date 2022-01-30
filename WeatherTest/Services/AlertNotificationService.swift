//
//  AlertNotificationService.swift
//  WeatherTest
//
//  Created by Tata on 28/01/22.
//

import UIKit

protocol AlertNotificationService {
    func showErrorAlert(self: UIViewController, title: String, message: String)
}

final class AlertNotificationServiceImp: AlertNotificationService {
    
    func showErrorAlert(self: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}
