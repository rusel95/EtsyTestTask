//
//  BookmarksViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit
import CoreData

class BookmarksCollectionViewController: UICollectionViewController {
    
    var controller: NSFetchedResultsController<CoreProduct>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFrames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadWithNewData()
    }
}

//MARK: UICollectionViewDataSource
extension BookmarksCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductsContainer.shared.databaseProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.productCell, for: indexPath) as! ProductCollectionViewCell
        
        product.coreInfo = ProductsContainer.shared.databaseProducts[indexPath.item]
        
        return product
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Storyboard.showDetailSegue, sender: ProductsContainer.shared.databaseProducts[indexPath.item] )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDetailSegue {
            let detailVC = segue.destination as! DetailViewController
            detailVC.coreInfo = sender as! DatabaseProduct
        }
    }
}

//MARK: more functions
extension BookmarksCollectionViewController {
    
    struct Storyboard {
        static let productCell = "ProductCollectionViewCell"
        static let showDetailSegue = "ShowBookmarksDetail"
        
        static let leftAndRightPaddings : CGFloat = 7.0
        static let numberOfItemsPerRow : CGFloat = 3.0
    }
    
    func setFrames() {
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = collectionViewWidth! / Storyboard.numberOfItemsPerRow - Storyboard.leftAndRightPaddings
        let itemHeight = itemWidth * ( HelperInstance.shared.defaulrImageSize.1 / HelperInstance.shared.defaulrImageSize.0)  //proper resolution
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    func reloadWithNewData() {
        ProductsContainer.shared.databaseProducts = DatabaseModel.shared.getCoreProducts()
        self.collectionView?.reloadData()
    }
}
