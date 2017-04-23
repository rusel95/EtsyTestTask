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
            Alamofire.request(info.imageURL).responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    self.photoImageView.image = image
                }
            }
//            let imageCache = AutoPurgingImageCache()
//            
//            
//            let urlRequest = URLRequest(url: URL(string: info.imageURL)!)
//            let tempImage = UIImage(named: info.name)!.af_imageRoundedIntoCircle()
//            
//            // Add
//            imageCache.add(tempImage, for: urlRequest, withIdentifier: info.name)
//            
//            // Fetch
//            photoImageView.image = imageCache.image(for: urlRequest, withIdentifier: info.name)
        }
    }
}
