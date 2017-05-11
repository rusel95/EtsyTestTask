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
    @IBOutlet weak var imageDownloadIndicator : UIActivityIndicatorView!
    
    //MARK: Set cell with data
    var info: Product! {
        didSet {
            imageDownloadIndicator.startAnimating()
            imageDownloadIndicator.hidesWhenStopped = true
            
            EtsyAPI.shared.getImage(listingId: info.listingId!) { (image) in
                
                self.photoImageView.image = image
                self.nameLabel.text = self.info.name
                self.imageDownloadIndicator.stopAnimating()
            }
        }
    }
    
    var coreInfo: DatabaseProduct! {
        didSet {
            nameLabel.text = coreInfo.name
            photoImageView.image = coreInfo.image
        }
    }
}
