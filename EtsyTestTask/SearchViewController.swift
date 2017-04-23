//
//  ViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 20.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

var categoriesContainer = [String]()

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryPickerView.dataSource = self
        self.categoryPickerView.delegate = self
        
        EtsyAPI.shared.getCategories { categories in
            categoriesContainer = categories
            self.categoryPickerView.reloadAllComponents()
        }
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesContainer.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesContainer[row]
    }
}

