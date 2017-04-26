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
    
    @IBOutlet weak var addOutlet: UIButton!
    @IBAction func addButton(_ sender: UIButton) {
        DatabaseModel.shared.saveProduct(with: info)
        createAlert(title: "Adding", message: "Product added! Continue shopping... ", controllerToDismiss: navigationController!)
    }
    
    @IBOutlet weak var deleteOutlet: UIButton!
    @IBAction func deleteButton(_ sender: Any) {
        DatabaseModel.shared.deleteProduct(coreProduct: coreInfo)
        createAlert(title: "Deleting", message: "Product deleted! Continue shopping... ", controllerToDismiss: navigationController!)
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
            if DatabaseModel.shared.ifProductInDatabase(newProduct: info) {
                addOutlet.isHidden = true
                deleteOutlet.isHidden = false
            } else {
                addOutlet.isHidden = false
                deleteOutlet.isHidden = true
            }
        } else if coreInfo != nil {
            nameLabel.text = coreInfo.name
            photoImageView.image = coreInfo.image
            priceLabel.text = coreInfo.price
            detailTextView.text = coreInfo.description
            addOutlet.isHidden = true
            deleteOutlet.isHidden = false
        }
    }
    
}
//MARK: Alert to check logOut
extension DetailViewController {
    
    func createAlert(title: String, message: String, controllerToDismiss: UINavigationController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction.init(title: "Continue", style: UIAlertActionStyle.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = controllerToDismiss.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
