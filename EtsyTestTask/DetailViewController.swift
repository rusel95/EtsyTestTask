//
//  DetailViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBAction func actionButton(_ sender: UIButton) {
    }
    
    var info = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = info.name
        
        priceLabel.text = info.price
        detailTextView.text = info.description
        
    }
    
}
