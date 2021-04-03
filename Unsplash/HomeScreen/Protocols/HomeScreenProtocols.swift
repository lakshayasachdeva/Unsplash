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
}


// Presenter => View protocol
protocol ImagesScreenPresenterProtocol: class {
    func viewDidLoad()
    var view: ImagesScreenViewProtocol? {get set}
    var interactor: ImagesScreenInputInteractorProtocol? {get set}
    var wireframe: ImageScreenRouterProtocol? {get set}
    func getImages(forPageNum pageNum:Int)    
    func showFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol)
    
}


// Presenter => Interactor
protocol ImagesScreenInputInteractorProtocol: class {
    var presenter: ImageScreenOutputInteractorOutputProtocol? {get set}
    func fetchImages(forPageNum pageNum:Int)
    
}


// Ineractor => Presenter
protocol ImageScreenOutputInteractorOutputProtocol: class {
    func didFetchImages(forPageNum pageNum:Int, andImages images:[ImageModel]?)
}

// Router
protocol ImageScreenRouterProtocol: class {
    func goToFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol)
}




