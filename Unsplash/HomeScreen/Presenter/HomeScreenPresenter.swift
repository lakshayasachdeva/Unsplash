//
//  HomeScreenPresenter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation
import UIKit




class HomeScreenPresenter: HomeScreenPresenterProtocol, HomeScreenOutputInteractorProtocol {
        
    private weak var view: HomeScreenViewProtocol?
    private var interactor: HomeScreenInputInteractorProtocol?
    private var wireframe: HomeScreenRouterProtocol?
    
    required init(view: HomeScreenViewProtocol, interactor: HomeScreenInputInteractorProtocol, router: HomeScreenRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = router
    }
    
    func getImages(forPageNum pageNum: Int) {
        interactor?.fetchImagesFromServer(forPageNum: pageNum)
    }
    
    func didTapOnSearchView() {
        wireframe?.goToSearchScreen()
    }
    
    func didFetchImages(forPageNum pageNum: Int, andImages images: [ImageModel]?) {
        view?.showImages(withImageData: images)
    }
    
}


