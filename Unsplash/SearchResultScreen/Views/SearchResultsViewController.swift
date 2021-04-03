//
//  SearchResultsViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    
    class func getSearchResultVC() -> SearchResultsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBar()
        addFilterIcon()
    }
    
    // MARK: UI elements setup methods
    func addFilterIcon(){
        let filterBtn = UIBarButtonItem(image: AppConstants.sortIcon, style: .plain, target: self, action: #selector(handleSortBtnTap))
        self.navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = filterBtn
    }
    
    
    func addSearchBar(){
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = AppConstants.searchBarPlaceholderText
        navigationItem.titleView = searchBar
        // This is to show the keyboard as soon as user lands on this screen..
        searchBar.becomeFirstResponder()
    }
    
    
    // MARK: Action methods
    @objc func handleSortBtnTap(){
        // TODO: Go to sort and filter screen...
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdvancedSearchViewController") as! AdvancedSearchViewController
//        let emptyBackButton = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        navigationController?.navigationBar.topItem?.backBarButtonItem = emptyBackButton
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SearchResultsViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //        photoArray.removeAll()
        //        collectionView.reloadData()
        //        searchKeyword = searchBar.text
        //        currentPage = 0
        //        searchPhotos()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
