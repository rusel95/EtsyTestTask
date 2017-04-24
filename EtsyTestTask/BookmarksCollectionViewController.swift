//
//  BookmarksViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class BookmarksCollectionViewController: UICollectionViewController {

    struct Storyboard {
        static let productCell = "ProductCollectionViewCell"
        static let showDetailSegue = "ShowBookmarksDetail"
        
        static let leftAndRightPaddings : CGFloat = 20.0
        static let numberOfItemsPerRow : CGFloat = 3.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFrames()
    
    }
    
    private func setFrames() {
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings) / Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
    }
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductsContainer.shared.array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.productCell, for: indexPath) as! ProductCollectionViewCell
        
        product.info = ProductsContainer.shared.array[indexPath.item]
        
        return product
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Storyboard.showDetailSegue, sender: ProductsContainer.shared.array[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDetailSegue {
            let detailVC = segue.destination as! DetailViewController
            detailVC.info = sender as! Product
        }
    }

}
