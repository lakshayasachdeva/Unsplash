//
//  HomeScreenProtocols.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation
import UIKit


protocol ImagesScreenViewProtocol: class {
    var imagesCollectionView: UICollectionView! {
        get set
    }
    func registerCollectionViewCellNibs()
    var imagesArray: [ImageModel]? {get set}
    func showImages(withImageData data:[ImageModel]?)
    var presenter: ImagesScreenPresenterProtocol? {get set}
    var currentPage: Int {get set}
}


// Presenter => View protocol
protocol ImagesScreenPresenterProtocol: class {
    func viewDidLoad()
    var view: ImagesScreenViewProtocol? {get set}
    var interactor: ImagesScreenInputInteractorProtocol? {get set}
    var wireframe: ImageScreenRouterProtocol? {get set}
    func getImages(forPageNum pageNum:Int)
    
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
@objc protocol ImageScreenRouterProtocol: class {
    @objc optional func goToSearchScreen()
    func goToFullImageScreen()
}




