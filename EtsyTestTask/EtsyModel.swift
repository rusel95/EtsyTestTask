//
//  SearchModel.swift
//  EtsyTestTask
//
//  Created by Admin on 20.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Product {
    let name : String
    let imageURL : String
    let price : String
    let description: String
}

struct Products {
    
    static var shared = Products()
    private init() { }
    
    var array = [Product]()
}

class EtsyAPI {
    
    static let shared = EtsyAPI()
    private init() { }
    
    private let categoriesRequestURL = "https://openapi.etsy.com/v2/taxonomy/categories?api_key=l6pdqjuf7hdf97h1yvzadfce"
    private var productsSearchRequestURL = "https://openapi.etsy.com/v2/listings/active?api_key=l6pdqjuf7hdf97h1yvzadfce&category="
    
    var categoriesArray = [String]()
    
    func getCategories() -> Void {
        
        Alamofire.request(categoriesRequestURL).responseJSON { response in
            
            let json = JSON(response.result.value!)
            let categories = json["results"]
            for categorie in categories {
                self.categoriesArray.append(categorie.1["long_name"].string!)
                //                print(categorie.1["long_name"])
            }
        }
    }
    
    func getProducts(inCategory: String) {
        productsSearchRequestURL += inCategory
        productsSearchRequestURL += "&keywords=terminator"
        Alamofire.request(productsSearchRequestURL).responseJSON { response in
            let json = JSON(response.result.value!)
            let productList = json["results"]
            for product in productList {
                Products.shared.array.append(Product(name: product.1["title"].string!,
                                                     imageURL: product.1["url"].string!,
                                                     price: product.1["price"].string!,
                                                     description: product.1["description"].string!))
            }
        }
    }
    
}
