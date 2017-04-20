//
//  SearchModel.swift
//  EtsyTestTask
//
//  Created by Admin on 20.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import Alamofire

class SearchModel {
    
    static let shared = SearchModel()
    
    private init() { }
    
    private let categoriesRequestURL = "https://openapi.etsy.com/v2/taxonomy/categories?api_key=l6pdqjuf7hdf97h1yvzadfce"
    
    
    func getCategories() {
        
        Alamofire.request(categoriesRequestURL).responseJSON { response in
            
            if let JSON = response.result.value {
//               print("JSON: \(JSON) ------------------------------------------------------------------------------")
//                if let name = (JSON as AnyObject)["name"]! as? String {
//                    userProfile.0 = name
//                }
                

                
                if let categories = (JSON as? NSDictionary){
                    print(categories)
                }
            }
        }
    }
    
}
