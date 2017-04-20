//
//  ViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 20.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchModel.shared.getCategories()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

