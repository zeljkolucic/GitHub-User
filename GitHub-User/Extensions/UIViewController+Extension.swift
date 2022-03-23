//
//  UIViewController+Extension.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        // Everything regarding UI has to be done on main thread, better to do it here than every time when calling this function
        DispatchQueue.main.async {
            let alertViewController = AlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
}
