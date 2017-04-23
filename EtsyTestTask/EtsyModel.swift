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
    
    private let apiKey = "?api_key=l6pdqjuf7hdf97h1yvzadfce"
    private let categoriesRequestURL = "https://openapi.etsy.com/v2/taxonomy/categories"
    private let productsSearchRequestURL = "https://openapi.etsy.com/v2/listings/active"
    private let listingImagesURL = "https://openapi.etsy.com/v2/listings/"
    
    func getCategories(giveData: @escaping ([String]) -> () ) -> Void {
        
        Alamofire.request(categoriesRequestURL + apiKey).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                var categories = [String]()
                let json = JSON(response.result.value!)
                let categoriesJSON = json["results"]
                for categorie in categoriesJSON {
                    categories.append(categorie.1["long_name"].string!)
                }
                giveData(categories)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getProducts(inCategory: String, giveData: @escaping () -> () ) -> Void {
        
        let neededURL = productsSearchRequestURL + apiKey + "&category=" + inCategory + "&keywords=terminator"
        
        Alamofire.request(neededURL).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                let productList = json["results"]
 
                for product in productList {
                    
                    var tempProduct = Product()
                    
                    if let name = product.1["title"].string {
                        tempProduct.name = name
                    }
                    if let listingId = product.1["listing_id"].int {
                        tempProduct.listingId = String(listingId)
                    } else {
                        print("\n\nerror whyle getting listing_id from json\n\n")
                    }
                    if let price = product.1["price"].string {
                        tempProduct.price = price
                    }
                    if let descriprion = product.1["description"].string {
                        tempProduct.description = descriprion
                    }
                    ProductsContainer.shared.array.append(tempProduct)
                }
                giveData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImage(listingId: String/*, giveData: @escaping () -> ()*/) -> Void {
        
        let currentImageURL = listingImagesURL + listingId + "/images" + apiKey
        
        Alamofire.request(currentImageURL).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
                
                //giveData(json)
            case .failure(let error):
                print("Error: ", error, "\nin: ", currentImageURL)
            }
        }
        
        
    }
    
    
    
}
