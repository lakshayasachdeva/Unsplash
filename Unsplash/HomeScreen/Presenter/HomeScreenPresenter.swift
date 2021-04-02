//
//  HomeScreenPresenter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation


class HomeScreenPresenter: ImagesScreenPresenterProtocol, ImageScreenOutputInteractorOutputProtocol{
    
    
    
    weak var view: ImagesScreenViewProtocol?
    var interactor: ImagesScreenInputInteractorProtocol?
    var wireframe: ImageScreenRouterProtocol?
    
    func viewDidLoad() {
        getImages(forPageNum: 0)
    }
    
    
    func didFetchImages(forPageNum pageNum: Int, andImages images: [ImageModel]?) {
        view?.showImages(withImageData: images)
    }
    
    func getImages(forPageNum pageNum: Int) {
        interactor?.fetchImages(forPageNum: pageNum)
    }
    
    
    
    
}
