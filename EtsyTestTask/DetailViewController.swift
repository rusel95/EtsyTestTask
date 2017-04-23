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
    
    var name : String!
    //photoImageView.image =
//    var price : String!
//    var detail : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
    }
    
}
