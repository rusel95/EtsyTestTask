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
    
    var refreshControll: UIRefreshControl! = UIRefreshControl()
    
    var isDataLoading : Bool = false
    var pageNo : Int = 0
    var limit : Int = 25
    var offset : Int = 0 //pageNo*limit
    var didEndReached : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFramesAndViews()

        setRefreshControll()
        
        refreshData()
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
        
        print("scrollViewDidEndDragging")
        
        if (((collectionView?.contentOffset.y)! + (collectionView?.frame.size.height)!) >= (collectionView?.contentSize.height)!) {
            
            if !isDataLoading{
                self.isDataLoading = true
                self.pageNo = self.pageNo + 1
                self.limit = self.limit + 10
                self.offset = self.limit * self.pageNo
                //loadCallLogData(offset: self.offset, limit: self.limit)
                print("loadCallLogData(offset: ", offset, ",limit: ", limit)
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
    
    func setFramesAndViews() {
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = collectionViewWidth! / Storyboard.numberOfItemsPerRow - Storyboard.leftAndRightPaddings
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        searchActivityIndicator.color = UIColor.blue
        searchActivityIndicator.startAnimating()
    }
    
    func setRefreshControll(){
        refreshControll.addTarget(self, action: #selector(SearchResultsCollectionViewController.refreshData), for: UIControlEvents.valueChanged)
        refreshControll.tintColor = UIColor.blue
        refreshControll.attributedTitle = NSAttributedString(string: "refreshing...", attributes: [NSForegroundColorAttributeName: refreshControll.tintColor])
        collectionView?.refreshControl = refreshControll
    }
    
    func refreshData() {
        
        ProductsContainer.shared.foundProducts.removeAll() //needed because every time whyle downloaing data appends
        
        EtsyAPI.shared.getProducts(inCategory: dataForSearch.0, withKeywords: dataForSearch.1) {
            
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
}
