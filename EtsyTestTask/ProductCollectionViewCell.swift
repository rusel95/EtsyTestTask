//
//  ProductCollectionViewCell.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    //MARK: Set cell with data
    var info: Product! {
        didSet {
            nameLabel.text = info.name
 
//            EtsyAPI.shared.getImage(listingId: info.listingId) { (image) in
//                self.photoImageView.image = image
//            }
            
            EtsyAPI.shared.getImage(listingId: info.listingId) { (image) in
                self.photoImageView.image = image
            }
            
        }
    }
}
