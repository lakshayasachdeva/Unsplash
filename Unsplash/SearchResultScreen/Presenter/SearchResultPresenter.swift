//
//  SearchResultPresenter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 04/04/21.
//

import Foundation
import UIKit


class SearchResultPresenter: SearchResultScreenPresenterProtocol, SearchResultScreenOutputInteractorProtocol{
    var view: SearchResultScreenViewProtocol?
    var interactor: SearchResultScreenInputInteractorProtocol?
    var router: SearchResultScreenRouterProtocol?
    
    required init(view: SearchResultScreenViewProtocol, interactor: SearchResultScreenInputInteractorProtocol, router: SearchResultScreenRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func searchImages(withKeyword keyword: String, withPageNum pageNum: Int) {
        interactor?.fetchImagesFromServer(withKeyword: keyword, withPageNum: pageNum)
    }
    
    func didTapOnFilterButton() {
        router?.goToFilterScreen()
    }
    
    func didFetchImages(forPageNum pageNum: Int, andImages images: [ImageModel]?) {
        view?.showImages(withImageData: images)
    }
    
    func filterButtonStatus(toShow: Bool, imageToShow: UIImage?) {
        view?.setFilterIconVisibility(toBeShown: toShow, withIamge: imageToShow)
    }
}
