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

class EtsyAPI {
    
    static let shared = EtsyAPI()
    private init() { }
    
    private let categoriesRequestURL = "https://openapi.etsy.com/v2/taxonomy/categories?api_key=l6pdqjuf7hdf97h1yvzadfce"
    private var productsSearchRequestURL = "https://openapi.etsy.com/v2/listings/active?api_key=l6pdqjuf7hdf97h1yvzadfce"
    
    
    
    
    func getCategories(giveData: @escaping ([String]) -> () ) -> Void {
        
        Alamofire.request(categoriesRequestURL).responseJSON { response in
            var categories = [String]()
            let json = JSON(response.result.value!)
            let categoriesJSON = json["results"]
            for categorie in categoriesJSON {
                categories.append(categorie.1["long_name"].string!)
            }
            giveData(categories)
        }
    }
    
    func getProducts(inCategory: String, giveData: @escaping () -> () ) -> Void {
        productsSearchRequestURL += "&category=" + inCategory
        productsSearchRequestURL += "&keywords=terminator"
        Alamofire.request(productsSearchRequestURL).responseJSON { response in
            let json = JSON(response.result.value!)
            let productList = json["results"]
            for product in productList {
                ProductsContainer.shared.array.append(Product(name: product.1["title"].string!,
                                                     imageURL: product.1["url"].string!,
                                                     price: product.1["price"].string!,
                                                     description: product.1["description"].string!))
            }
            giveData()
        }
    }
    
    
    
}
