//
//  HomeScreenProtocols.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation
import UIKit


protocol ImagesScreenViewProtocol: class, UIViewControllerTransitioningDelegate {
    var imagesCollectionView: UICollectionView! {
        get set
    }
    func registerCollectionViewCellNibs()
    var imagesArray: [ImageModel]? {get set}
    func showImages(withImageData data:[ImageModel]?)
    var presenter: ImagesScreenPresenterProtocol? {get set}
    var screenType: ScreenType { get set}
    func setFilterIconVisibility(toBeShown status:Bool, withIamge image:UIImage?)
}


// Presenter => View protocol
protocol ImagesScreenPresenterProtocol: class {
    func viewDidLoad()
    var view: ImagesScreenViewProtocol? {get set}
    var interactor: ImagesScreenInputInteractorProtocol? {get set}
    var wireframe: ImageScreenRouterProtocol? {get set}
    func getImages(forPageNum pageNum:Int)    
    func showFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol)
    func showSearchScreen()
    func searchImages(withKeyword keyword:String, withPageNum pageNum:Int)
    func showFilterScreen()
}


// Presenter => Interactor
protocol ImagesScreenInputInteractorProtocol: class {
    var presenter: ImageScreenOutputInteractorOutputProtocol? {get set}
    func fetchImages(forPageNum pageNum:Int)
    func searchImages(withKeyword keyword:String, withPageNum pageNum:Int)
}


// Ineractor => Presenter
protocol ImageScreenOutputInteractorOutputProtocol: class {
    func didFetchImages(forPageNum pageNum:Int, andImages images:[ImageModel]?)
    func filterButtonStatus(toShow:Bool, imageToShow:UIImage?)
}

// Router
protocol ImageScreenRouterProtocol: class {
    func goToFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol)
    func goToSearchScreen(presentFrom viewRef: ImagesScreenViewProtocol)
    func goToFilterScreen(presentFrom viewRef: ImagesScreenViewProtocol)
}



