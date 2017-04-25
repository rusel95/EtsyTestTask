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
    
    //MARK: Save to CoreData
    @IBAction func actionButton(_ sender: UIButton) {
        DatabaseCRUD.shared.saveProduct(with: info)
    }
    
    var info : Product!
    var coreInfo : DatabaseProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    private func setView() {
        if info != nil {
            nameLabel.text = info.name
            photoImageView.image = ProductsContainer.shared.imageCache.image(withIdentifier: info.listingId)
            priceLabel.text = info.price
            detailTextView.text = info.description
        } else {
            nameLabel.text = coreInfo.name
            photoImageView.image = coreInfo.image
            priceLabel.text = coreInfo.price
            detailTextView.text = coreInfo.description
        }
    }
    
}
