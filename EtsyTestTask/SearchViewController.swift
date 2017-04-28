//
//  ViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 20.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var categoriesContainer = [(String,String)]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var downloadingLabel: UILabel!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var downloadingActivityIndicator: UIActivityIndicatorView!
   
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        if searchTextField.text != "" {
            ProductsContainer.shared.foundProducts.removeAll()
            ProductsContainer.shared.imageCache.removeAllImages()
            
            let searchData : (String, String) = (categoriesContainer[categoryPickerView.selectedRow(inComponent: 0)].0 , searchTextField.text!)
            self.performSegue(withIdentifier: "ShowSearchResults", sender: searchData)
        } else {
            HelperInstance.shared.createAlert(title: "OoOops", message: "Looks like you have`t entered any product name.. Please, do that!", currentView: self, controllerToDismiss: self.navigationController!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchResults" {
            let showSearchResultsCVC = segue.destination as! SearchResultsCollectionViewController
            showSearchResultsCVC.dataForSearch = sender as! (String, String)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryPickerView.dataSource = self
        self.categoryPickerView.delegate = self
        
        categoriesDownloading()
    }
    
    private func categoriesDownloading() {
        
        self.categoryPickerView.isHidden = true
        self.submitButton.isHidden = true
        self.chooseLabel.isHidden = true
        self.downloadingActivityIndicator.startAnimating()
        
        EtsyAPI.shared.getCategories { categories in
            self.categoriesContainer = categories
            self.categoryPickerView.isHidden = false
            self.submitButton.isHidden = false
            self.downloadingLabel.isHidden = true
            self.chooseLabel.isHidden = false
            self.downloadingActivityIndicator.stopAnimating()
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
        return categoriesContainer[row].1
    }
}

