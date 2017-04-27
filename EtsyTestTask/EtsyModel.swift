//
//  SearchModel.swift
//  EtsyTestTask
//
//  Created by Admin on 20.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class EtsyAPI {
    
    static var shared = EtsyAPI()
    private init() { }
    
    private let apiKey = "?api_key=l6pdqjuf7hdf97h1yvzadfce"
    private let categoriesRequestURL = "https://openapi.etsy.com/v2/taxonomy/categories"
    private let productsSearchRequestURL = "https://openapi.etsy.com/v2/listings/active"
    private let listingImagesRequestURL = "https://openapi.etsy.com/v2/listings/"
    
    func getCategories(giveData: @escaping ([(String,String)]) -> () ) -> Void {
        
        Alamofire.request(categoriesRequestURL + apiKey).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                var categories = [(String,String)]()
                let json = JSON(response.result.value!)
                let categoriesJSON = json["results"]
                for categorie in categoriesJSON {
                    categories.append((categorie.1["category_name"].string!, categorie.1["long_name"].string!) )
                }
                giveData(categories)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProducts(inCategory: String, withKeywords: String, giveData: @escaping () -> () ) -> Void {
        let neededURL = productsSearchRequestURL + apiKey + "&category=" + inCategory + "&keywords=" + withKeywords
        
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
                        tempProduct.price = price + " $"
                    }
                    if let descriprion = product.1["description"].string {
                        tempProduct.description = descriprion
                    }
                    ProductsContainer.shared.foundProducts.append(tempProduct)
                }
                giveData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getImage(listingId: String, giveImage: @escaping (UIImage) -> () ) -> Void {
        
        if let image = ProductsContainer.shared.imageCache.image(withIdentifier: listingId) {
            giveImage( image )
        } else {
            
            getImageURL(listingId: listingId) { (realImageURL) in
                
                Alamofire.request(realImageURL).validate().responseImage { response in
                    
                    if let realImage = response.result.value {
                        // Add to Alamofire cache
                        ProductsContainer.shared.imageCache.add(realImage, withIdentifier: listingId)
                        
                        //Fetch From Alamofire cache and give data
                        giveImage( realImage )
                    }
                }
            }
        }
    }
    
    
    func getImageURL(listingId: String, giveData: @escaping (String) -> () ) -> Void {
        
        let currentImageRequestURL = listingImagesRequestURL + listingId + "/images" + apiKey
        
        Alamofire.request(currentImageRequestURL).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                let results = json["results"].array!
                let imageURL = results[0]["url_170x135"].string!
                giveData(imageURL)
                
            case .failure(let error):
                print("Error: ", error, "\nin: ", currentImageRequestURL)
            }
        }
    }
    
}
