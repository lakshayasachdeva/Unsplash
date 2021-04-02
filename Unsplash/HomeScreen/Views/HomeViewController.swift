//
//  HomeViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import UIKit

class HomeViewController: UIViewController, ImagesScreenViewProtocol {
    
    // MARK: IBOutlets
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var imagesArray: [ImageModel]?
    var presenter: ImagesScreenPresenterProtocol?
    private let twoColumnsLayout = ImageColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 20, minimumLineSpacing: 20, sectionInset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    var currentPage = 0
        
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCellNibs()
        setScreenTitle()
        setupCollectionView()
        HomeScreenModule.create(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    func registerCollectionViewCellNibs(){
        imagesCollectionView.register(ImageCollectionViewCell.cellNib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        imagesCollectionView.register(SearchBarCollectionReusableView.cellNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader.self, withReuseIdentifier: SearchBarCollectionReusableView.reuseIdentifier)
    }
    
    
    func setScreenTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = AppConstants.kHomeScreenTitle
    }
    
    func setupCollectionView(){
        imagesCollectionView.collectionViewLayout = twoColumnsLayout
        twoColumnsLayout.sectionHeadersPinToVisibleBounds = true
        twoColumnsLayout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: AppConstants.kSearchViewHeaderHeight)
        twoColumnsLayout.sectionHeadersPinToVisibleBounds = false
    }
    
    func showImages(withImageData data: [ImageModel]?) {
        guard let newImageData = data else {return}
        let previousCount = self.imagesArray?.count ?? 0
        if imagesArray == nil{
            imagesArray = newImageData
        } else{
            self.imagesArray!.append(contentsOf: newImageData)
        }
        
        if self.currentPage == 0 {
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

}




//MARK: UICollection view methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
            SearchBarCollectionReusableView.reuseIdentifier, for: indexPath) as! SearchBarCollectionReusableView
        header.delegate = self
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return header
        default:
            assert(false, "Unexpected element kind")
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == imagesArray!.count - 2 {
            currentPage = currentPage + 1
            presenter?.getImages(forPageNum: currentPage)
        }
    }
    
}



// MARK: Delegates

extension HomeViewController: SearchHeaderViewProtocol{
    
    func didTapOnView() {
        
    }
    
    
}
