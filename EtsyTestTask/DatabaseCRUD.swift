//
//  File.swift
//  EtsyTestTask
//
//  Created by Admin on 24.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit
import CoreData

//MARK: - my Core Data functions
class DatabaseCRUD {
    
    static let shared = DatabaseCRUD()
    private init () { }
    
    func saveProduct(with info: Product) -> Void {
        let product: CoreProduct = NSEntityDescription.insertNewObject(forEntityName: "CoreProduct", into: DatabaseController.getContext()) as! CoreProduct
        
        product.name = info.name
        if let image = UIImagePNGRepresentation( ProductsContainer.shared.imageCache.image(withIdentifier: info.listingId)! )! as NSData! {
            product.image = image
        }
        product.price = info.price
        product.descript = info.description
        
        DatabaseController.saveContext()
    }
    
    func getCoreProducts() -> [DatabaseProduct] {
        
        let fetchRequest: NSFetchRequest<CoreProduct> = CoreProduct.fetchRequest()
        var coreProducts = [DatabaseProduct]()
        do {
            
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            print("number of results:", searchResults.count)
            
            for result in searchResults as [CoreProduct] {
                coreProducts.append( DatabaseProduct(name: result.name,
                                                     image: UIImage(data: (result.image! as Data) ),
                                                     price: result.price,
                                                     description: result.descript) )
            }
            print(coreProducts)
            
        } catch {
            print("Error while fetching:", error)
        }
        
        return coreProducts
    }
    
    func deleteProduct(coreProduct: CoreProduct) -> Void {
        //DatabaseController.getContext().delete(product)
    }
}
