//
//  DatabaseModel.swift
//  CoreData Snippet
//
//  Copyright © 2017 rusel95. All rights reserved.
//
import UIKit
import CoreData

class DatabaseModel {
    
    static var shared = DatabaseModel()
    private init() {}
    
    class func getContext() -> NSManagedObjectContext {
        return DatabaseModel.persistentContainer.viewContext
    }
    
    //MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "EtsyTestTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: - Core Data Saving support
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//MARK: external extension for basic functions
extension DatabaseModel {
    
    func saveProduct(with info: Product) -> Void {
        
        if !ifProductInDatabase(newProduct: info) {
            
            let product: CoreProduct = NSEntityDescription.insertNewObject(forEntityName: "CoreProduct", into: DatabaseModel.getContext()) as! CoreProduct
            
            product.name = info.name
            if let image = UIImagePNGRepresentation( ProductsContainer.shared.imageCache.image(withIdentifier: info.listingId!)! )! as NSData! {
                product.image = image
            }
            product.price = info.price
            product.descript = info.description
            
            DatabaseModel.saveContext()
        } else {
            print("such product is already in Database")
        }
    }
    
    func getCoreProducts() -> [DatabaseProduct] {
        
        let fetchRequest: NSFetchRequest<CoreProduct> = CoreProduct.fetchRequest()
        var coreProducts = [DatabaseProduct]()
        do {
            
            let searchResults = try DatabaseModel.getContext().fetch(fetchRequest)
            
            for result in searchResults as [CoreProduct] {
                coreProducts.append( DatabaseProduct(name: result.name,
                                                     image: UIImage(data: (result.image! as Data) ),
                                                     price: result.price,
                                                     description: result.descript) )
            }
            
        } catch {
            print("Error while fetching:", error)
        }
        
        return coreProducts
    }
    
    func deleteProduct(coreProduct: DatabaseProduct) -> Void {
        
        let fetchRequest: NSFetchRequest<CoreProduct> = CoreProduct.fetchRequest()
        do {
            
            let searchResults = try DatabaseModel.getContext().fetch(fetchRequest)
            
            for result in searchResults as [CoreProduct] {
                if result.name == coreProduct.name {
                    DatabaseModel.getContext().delete(result)
                    DatabaseModel.saveContext()
                }
            }
            
        } catch {
            print("Error while fetching:", error)
        }
    }
    
    func ifProductInDatabase(newProduct: Product) -> Bool {
        
        var existing = false
        
        let currentDatabaseProducts = getCoreProducts()
        for product in currentDatabaseProducts {
            if newProduct.name == product.name {
                existing = true
            }
        }
        
        return existing
    }
    
}
