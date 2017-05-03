//
//  SingleTone.swift
//  EtsyTestTask
//
//  Created by Admin on 26.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit
import SystemConfiguration

class HelperInstance {
    
    let defaulrImageSize : (CGFloat,CGFloat) = (170, 135)
    
    static let shared = HelperInstance()
    private init () { }
    
    func createAlert(title: String, message: String, currentView: UIViewController, controllerToDismiss: UINavigationController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Continue", style: UIAlertActionStyle.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = controllerToDismiss.popViewController(animated: true)
        }))
        
        currentView.present(alert, animated: true, completion: nil)
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
}
