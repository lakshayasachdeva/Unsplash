//
//  HomeViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import UIKit

class HomeViewController: UIViewController, ImageScreenProtocol {
    
    // MARK: IBOutlets
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    private let twoColumnsLayout = ImageColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 20, minimumLineSpacing: 20, sectionInset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCellNibs()
        setScreenTitle()
        setupCollectionView()
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

}




//MARK: UICollection view methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
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
    
    
    
}



// MARK: Delegates

extension HomeViewController: SearchHeaderViewProtocol{
    
    func didTapOnView() {
        
    }
    
    
}
