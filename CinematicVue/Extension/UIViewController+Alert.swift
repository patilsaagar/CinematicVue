//
//  UIViewController+Alert.swift
//  CinematicVue
//
//  Created by sagar patil on 18/03/2022.
//

import UIKit

extension UIViewController {
    func showAlert(alertTitle: String, errorMessage: String) {
        let alertViewController = UIAlertController(title: alertTitle, message: errorMessage, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertViewController, animated: true, completion: nil)
    }
}
