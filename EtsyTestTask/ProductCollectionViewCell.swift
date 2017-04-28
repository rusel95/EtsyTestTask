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
            nameLabel.text = info.name
            imageDownloadIndicator.startAnimating()
            imageDownloadIndicator.hidesWhenStopped = true
            EtsyAPI.shared.getImage(listingId: info.listingId) { (image) in
                self.photoImageView.image = image
                self.imageDownloadIndicator.stopAnimating()
            }
            
        }
    }
    
//    var info: Product! {
//        didSet {
//            nameLabel.text = info.name
//            imageDownloadIndicator.startAnimating()
//            imageDownloadIndicator.hidesWhenStopped = true
//            EtsyAPI.shared.getImageURL(listingId: info.listingId) { (url) in
//                self.photoImageView.af_setImage(withURL: URL(fileURLWithPath: url) )
//                self.imageDownloadIndicator.stopAnimating()
//            }
//            
//        }
//    }

    var coreInfo: DatabaseProduct! {
        didSet {
            nameLabel.text = coreInfo.name
            photoImageView.image = coreInfo.image
        }
    }
}
