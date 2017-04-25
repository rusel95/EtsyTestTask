//
//  DetailViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var actionOutlet: UIButton!
    @IBAction func actionButton(_ sender: UIButton) {
        if info != nil {
            DatabaseModel.shared.saveProduct(with: info)
        } else {
            DatabaseModel.shared.deleteProduct(coreProduct: coreInfo)
        }
    }
    
    //need to find out who is controller`s parent
    var info : Product!
    var coreInfo : DatabaseProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView()
    }
    
    private func setView() {
        if info != nil {
            nameLabel.text = info.name
            photoImageView.image = ProductsContainer.shared.imageCache.image(withIdentifier: info.listingId)
            priceLabel.text = info.price
            detailTextView.text = info.description
            actionOutlet.titleLabel?.text = "Save to bookmarks"
        } else {
            nameLabel.text = coreInfo.name
            photoImageView.image = coreInfo.image
            priceLabel.text = coreInfo.price
            detailTextView.text = coreInfo.description
            actionOutlet.titleLabel?.text = "Delete from bookmarks"
        }
    }
    
}
