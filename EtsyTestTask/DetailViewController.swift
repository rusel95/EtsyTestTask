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

        let product: CoreProducts = NSEntityDescription.insertNewObject(forEntityName: "CoreProducts", into: DatabaseController.getContext()) as! CoreProducts
        
        product.name = info.name
        product.image = UIImagePNGRepresentation( ProductsContainer.shared.imageCache.image(withIdentifier: info.listingId)! )! as NSData
        product.price = info.price
        product.descript = info.description
        
        DatabaseController.saveContext()
        
        let fetchRequest: NSFetchRequest<CoreProducts> = CoreProducts.fetchRequest()
        
        do {
            
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            print("number of results:", searchResults.count)
            
            for result in searchResults as [CoreProducts] {
                print("\n\(result.name!) \n\(result.price!)")
            }
            
        } catch {
            print("Error while fetching:", error)
        }
        
        //DatabaseController.getContext().delete(product)
    }
    
    var info = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    private func setView() {
        nameLabel.text = info.name
        photoImageView.image = ProductsContainer.shared.imageCache.image(withIdentifier: info.listingId)
        priceLabel.text = info.price
        detailTextView.text = info.description
    }
    
}
