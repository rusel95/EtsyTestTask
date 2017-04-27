//
//  SingleTone.swift
//  EtsyTestTask
//
//  Created by Admin on 26.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class SingleTone {
    
    static let shared = SingleTone()
    private init () { }
    
    func createAlert(title: String, message: String, currentView: UIViewController, controllerToDismiss: UINavigationController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Continue", style: UIAlertActionStyle.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = controllerToDismiss.popViewController(animated: true)
        }))
        
        currentView.present(alert, animated: true, completion: nil)
    }
    
}
