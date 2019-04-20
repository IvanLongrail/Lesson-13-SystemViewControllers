//
//  AlertController.swift
//  Lesson 13 System View Controllers
//
//  Created by Иван longrail on 20/04/2019.
//  Copyright © 2019 Иван longrail. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertControllerWithMessage(_ message: String) {
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController,animated: true)
    }
}
