//
//  SearchResultsCollectionViewController.swift
//  EtsyTestTask
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

var isLoadingProducts = false

class SearchResultsCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    
    var dataForSearch : (String, String) = ("","")
    
    @objc var refreshControll: UIRefreshControl! = UIRefreshControl()
    
    @objc var isDataLoading : Bool = false
    @objc var currentPage : Int = 0
    @objc var limit : Int = 30
    @objc var offset : Int = 0 //pageNo*limit
    @objc var didEndReached : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFramesAndViews()
        
        setRefreshControll()
        
        self.refreshData()
    }
    
}

//MARK: UICollectionViewDataSource
extension SearchResultsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductsContainer.shared.foundProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.productCell, for: indexPath) as! ProductCollectionViewCell
        
        if ProductsContainer.shared.foundProducts.count != 0 {
            product.info = ProductsContainer.shared.foundProducts[indexPath.item]
        }
        
        return product
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Storyboard.showDetailSegue, sender: ProductsContainer.shared.foundProducts[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDetailSegue {
            let detailVC = segue.destination as! DetailViewController
            detailVC.info = sender as! Product
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((collectionView?.contentOffset.y)! + (collectionView?.frame.size.height)! >= (collectionView?.contentSize.height)! - (collectionView?.frame.size.width)! / 2.0) {
            if !isDataLoading{
                self.currentPage = self.currentPage + 1
                self.offset = self.limit * self.currentPage
                downloadMoreData(category: dataForSearch.0, keywords: dataForSearch.1)
            }
        }
    }
}

//MARK: more functions
extension SearchResultsCollectionViewController {
    
    struct Storyboard {
        static let productCell = "ProductCollectionViewCell"
        static let showDetailSegue = "ShowSearchDetail"
        
        static let leftAndRightPaddings : CGFloat = 7.0
        static let numberOfItemsPerRow : CGFloat = 3.0
    }
    
    @objc func setFramesAndViews() {
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = collectionViewWidth! / Storyboard.numberOfItemsPerRow - Storyboard.leftAndRightPaddings
        let itemHeight = itemWidth * ( HelperInstance.shared.defaulrImageSize.1 / HelperInstance.shared.defaulrImageSize.0)  //proper resolution
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        searchActivityIndicator.color = UIColor.blue
        searchActivityIndicator.startAnimating()
    }
    
    @objc func setRefreshControll(){
        refreshControll.addTarget(self, action: #selector(SearchResultsCollectionViewController.refreshData), for: UIControlEvents.valueChanged)
        refreshControll.tintColor = UIColor.blue
        refreshControll.attributedTitle = NSAttributedString(string: "refreshing...", attributes: [NSAttributedStringKey.foregroundColor: refreshControll.tintColor])
        collectionView?.refreshControl = refreshControll
    }
    
    @objc func refreshData() {
        
        ProductsContainer.shared.foundProducts.removeAll() //needed because every time whyle downloaing data appends
        
        self.offset = 0
        
        EtsyAPI.shared.getProducts(inCategory: dataForSearch.0, withKeywords: dataForSearch.1, limit: self.limit, offset: self.offset) { jsonAny in
            
            ProductsContainer.shared.setProducts(jsonAny: jsonAny!)

            if(ProductsContainer.shared.foundProducts.count == 0) {
                HelperInstance.shared.createAlert(title: "Something went wrong...", message: "Loooks like there is no any results ", currentView: self, controllerToDismiss: self.navigationController!)
            } else {
                self.refreshControll.endRefreshing()
                self.collectionView?.reloadData()
                self.searchActivityIndicator.stopAnimating()
                self.searchActivityIndicator.isHidden = true
            }
        }
    }
    
    @objc func downloadMoreData(category: String, keywords: String) {
        
        self.isDataLoading = true
        EtsyAPI.shared.getProducts(inCategory: category, withKeywords: keywords, limit: self.limit, offset: self.offset) { jsonAny in
            
            ProductsContainer.shared.setProducts(jsonAny: jsonAny!)

            self.isDataLoading = false
            
            if(ProductsContainer.shared.foundProducts.count == 0) {
                HelperInstance.shared.createAlert(title: "Something went wrong...", message: "Loooks like there is no more results for pagination...", currentView: self, controllerToDismiss: self.navigationController!)
            } else {
                self.collectionView?.reloadData()
            }
        }
        
    }
}
