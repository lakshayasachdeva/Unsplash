//
//  HomeScreenPresenter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation
import UIKit


class HomeScreenPresenter: ImagesScreenPresenterProtocol, ImageScreenOutputInteractorOutputProtocol{
    
    
    
    
    
    weak var view: ImagesScreenViewProtocol?
    var interactor: ImagesScreenInputInteractorProtocol?
    var wireframe: ImageScreenRouterProtocol?
    
    func viewDidLoad() {
        getImages(forPageNum: 1)
    }
    
    
    func didFetchImages(forPageNum pageNum: Int, andImages images: [ImageModel]?) {
        view?.showImages(withImageData: images)
    }
    
    func getImages(forPageNum pageNum: Int) {
        interactor?.fetchImages(forPageNum: pageNum)
    }
    
    func showFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl: String, presentFrom viewRef: ImagesScreenViewProtocol) {
        wireframe?.goToFullImageScreen(withSelectedImage: selectedImage, andFullImageUrl: imgUrl, presentFrom: viewRef)
    }
    
    
}
