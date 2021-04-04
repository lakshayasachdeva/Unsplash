//
//  HomeViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import UIKit

class HomeViewController: GridImagesViewController, HomeScreenViewProtocol {
    var presenter: HomeScreenPresenterProtocol?
        
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeaderView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setScreenTitle()
    }
    
    // MARK: private methods..
    private func setScreenTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = AppConstants.kHomeScreenTitle
    }
    
    private func addHeaderView(){
        if let flowLayout = imagesCollectionView.collectionViewLayout as? ImageColumnFlowLayout{
            flowLayout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: AppConstants.kSearchViewHeaderHeight)
            imagesCollectionView.collectionViewLayout = flowLayout
            imagesCollectionView.register(SearchBarCollectionReusableView.cellNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader.self, withReuseIdentifier: SearchBarCollectionReusableView.reuseIdentifier)
        }
    }
    
    override func getImages(forPageNum pageNum: Int){
        presenter?.getImages(forPageNum: pageNum)
    }
    
}

// Search header view delegate method
extension HomeViewController: SearchHeaderViewProtocol{
    
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
    
    
    func didTapOnView() {
        // Navigate user to the search view controller...
        presenter?.didTapOnSearchView()
    }
}




