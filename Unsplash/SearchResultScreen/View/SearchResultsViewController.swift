//
//  SearchResultsViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import UIKit

class SearchResultsViewController: GridImagesViewController, SearchResultScreenViewProtocol {
    
    var presenter: SearchResultScreenPresenterProtocol?
    private let searchBar = UISearchBar()
    private var searchKeyword: String?
    private var filterBtn: UIBarButtonItem?
    

    // MARK:- View lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Clearing saved filters as soon as this screen loads.
        FilterModel.clearAllSavedFilters()
        addSearchBar()
        addObserverForFiltersChange()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: UI elements setup methods
    private func addFilterIcon(withIcon icon:UIImage?){
        filterBtn = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(handleSortBtnTap))
        self.navigationItem.rightBarButtonItem = filterBtn
    }
    
    private func removeFilterIcon(){
        filterBtn = nil
        self.navigationItem.rightBarButtonItem = nil
    }
    
    private func addSearchBar(){
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = AppConstants.searchBarPlaceholderText
        navigationItem.titleView = searchBar
        // This is to show the keyboard as soon as user lands on this screen..
        searchBar.becomeFirstResponder()
    }
    
    override func getImages(forPageNum pageNum: Int){
        guard let searchStr = searchKeyword else {return}
        presenter?.searchImages(withKeyword: searchStr, withPageNum: pageNum)
    }
    
    
    // MARK: Protocol conformance method
    func setFilterIconVisibility(toBeShown status: Bool, withIamge image: UIImage?) {
        if status{
            removeFilterIcon()
            addFilterIcon(withIcon: image)
        } else{
            removeFilterIcon()
        }
    }
    
    // MARK: Action methods
    @objc func handleSortBtnTap(){
        presenter?.didTapOnFilterButton()
    }
    
    
    // MARK: Filter notification
    private func addObserverForFiltersChange(){
        NotificationCenter.default.addObserver(self, selector: #selector(didFilterChange), name: NSNotification.Name(rawValue: AppConstants.kUserDidApplyFilters), object: nil)
    }
    
    private func removeObserverForFiltersChange(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didFilterChange(){
        guard let searchString = searchKeyword else {
            return
        }
        currentPage = 1
        imagesArray?.removeAll()
        imagesCollectionView.reloadData()
        presenter?.searchImages(withKeyword: searchString, withPageNum: currentPage)
    }
    
    deinit {
        removeObserverForFiltersChange()
    }
    
}


// MARK: Search bar delegate methods
extension SearchResultsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        imagesArray?.removeAll()
        imagesCollectionView.reloadData()
        searchKeyword = searchBar.text
        currentPage = 1
        searchPhotos()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchPhotos(){
        guard let query = searchKeyword else {
            return
        }
        presenter?.searchImages(withKeyword: query, withPageNum: currentPage)
    }
}




