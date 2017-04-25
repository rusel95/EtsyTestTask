//
//  Product.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import AlamofireImage

struct Product {
    var name : String!
    var listingId : String!
    var price : String!
    var description: String!
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
}
