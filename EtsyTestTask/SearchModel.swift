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

class SearchModel {
    
    static let shared = SearchModel()
    
    private init() { }
    
    private let categoriesRequestURL = "https://openapi.etsy.com/v2/taxonomy/categories?api_key=l6pdqjuf7hdf97h1yvzadfce"
    
    var categoriesArray = [String]()
    
    func getCategories() {
        
        Alamofire.request(categoriesRequestURL).responseJSON { response in
            
            let json = JSON(response.result.value!)
            let categories = json["results"]
            for categorie in categories {
                print(categorie.1["long_name"])
            }
        }
    }
    
}
