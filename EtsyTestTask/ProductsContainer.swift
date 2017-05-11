//
//  Product.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import AlamofireImage
import SwiftyJSON

struct Product {
    var name : String?
    var listingId : String?
    var price : String?
    var description: String?
    
    static let currentProduct = Product()
    
    
    
    mutating func resetUser() {
        self.name = nil
        self.listingId = nil
        self.price = nil
        self.description = nil
    }
}

struct DatabaseProduct {
    var name : String!
    var image : UIImage!
    var price : String!
    var description: String!
}

struct ProductsContainer {
    
    static var shared = ProductsContainer()
    private init() { }
    
    var foundProducts = [Product]()
    var databaseProducts = [DatabaseProduct]()
    let imageCache = AutoPurgingImageCache()
    
    mutating func setProducts(jsonAny: Any) {
        
        let json = JSON(jsonAny)
        
        let productList = json["results"]
        
        for product in productList {
            var tempProduct = Product()
            
            if let name = product.1["title"].string {
                tempProduct.listingId = name
            }
            if let listingId = product.1["listing_id"].int {
                tempProduct.listingId = String(listingId)
            }
            if let price = product.1["price"].string {
                tempProduct.price = price + " $"
            }
            if let descriprion = product.1["description"].string {
                tempProduct.description = descriprion
            }
            self.foundProducts.append(tempProduct)
        }
    }
}
