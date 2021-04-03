//
//  SearchResultsViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import UIKit

class SearchResultsViewController: UIViewController, ImagesScreenViewProtocol {
    

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var imagesArray: [ImageModel]?
    var presenter: ImagesScreenPresenterProtocol?
    private var currentPage = 1
    private var selectedIndex = 0
    private var selectedImage: UIImage!
    private var animationController = ImageTransitionController()
    private let searchBar = UISearchBar()
    private let twoColumnsLayout = ImageColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 20, minimumLineSpacing: 20, sectionInset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    private var searchKeyword: String?
    var screenType: ScreenType = .search


    
    class func getSearchResultVC() -> SearchResultsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBar()
        addFilterIcon()
        setupCollectionView()
        registerCollectionViewCellNibs()
        SearchResultScreenModule.create(viewRef: self)
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
    func registerCollectionViewCellNibs() {
        imagesCollectionView.register(ImageCollectionViewCell.cellNib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
    }
    
    
    func showImages(withImageData data: [ImageModel]?) {
        guard let newImageData = data else {return}
        let previousCount = self.imagesArray?.count ?? 0
        if imagesArray == nil{
            imagesArray = newImageData
        } else{
            self.imagesArray!.append(contentsOf: newImageData)
        }
        if self.currentPage == 1 {
            imagesCollectionView.reloadData()
        }else {
            var indexPaths = [IndexPath]()
            for i in previousCount..<imagesArray!.count {
                let indexPath = IndexPath(item: i, section: 0)
                indexPaths.append(indexPath)
            }
            imagesCollectionView.insertItems(at: indexPaths)
        }
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
    
    func setupCollectionView(){
        imagesCollectionView.collectionViewLayout = twoColumnsLayout
    }
    
    
    // MARK: Action methods
    @objc func handleSortBtnTap(){
        // TODO: Go to sort and filter screen...
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdvancedSearchViewController") as! AdvancedSearchViewController
//        let emptyBackButton = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        navigationController?.navigationBar.topItem?.backBarButtonItem = emptyBackButton
//        navigationController?.pushViewController(vc, animated: true)
        presenter?.showFilterScreen()
    }
    
}


extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = imagesArray else {return 0}
        let imagesCount = images.count
        if imagesCount == 0{
            imagesCollectionView.setEmptyMessage(AppConstants.kEmptyRecordsMessage)
        } else{
            imagesCollectionView.restore()
        }
        return imagesCount
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.imgView.image = nil
        ImageDownloadManager.sharedInstance.addDownloadTaskFor(urlString: imagesArray![indexPath.row].urls!.thumb!) { [weak self] (url, image) in
            if url == self?.imagesArray![indexPath.row].urls!.thumb! {
                cell.imgView.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == imagesArray!.count - 2 {
            currentPage = currentPage + 1
            presenter?.getImages(forPageNum: currentPage)
        }
        ImageDownloadManager.sharedInstance.increasePriorityFor(urlString: imagesArray![indexPath.row].urls!.thumb!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //Check if index path is still valid
        if indexPath.row < imagesArray!.count {
            ImageDownloadManager.sharedInstance.decreasePriorityFor(urlString: imagesArray![indexPath.row].urls!.thumb!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        guard let image = cell.imgView.image else {
            return
        }
        selectedIndex = indexPath.row
        selectedImage = image
        presenter?.showFullImageScreen(withSelectedImage: selectedImage, andFullImageUrl: imagesArray![indexPath.row].urls!.full!, presentFrom: self)
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
