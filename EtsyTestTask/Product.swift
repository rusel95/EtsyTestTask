//
//  Product.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation

struct Product {
    let name : String
    let imageURL : String
    let price : String
    let description: String
}

struct ProductsContainer {
    
    static var shared = ProductsContainer()
    private init() { }
    
    var array = [Product]()
}
