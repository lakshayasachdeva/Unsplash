//
//  SearchResultScreenProtocols.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 04/04/21.
//

import Foundation
import UIKit


protocol SearchResultScreenViewProtocol: class, GridImagesViewProtocol {
    var presenter: SearchResultScreenPresenterProtocol? {get set}
    func setFilterIconVisibility(toBeShown status:Bool, withIamge image:UIImage?)
}


protocol SearchResultScreenPresenterProtocol: class {
    var view: SearchResultScreenViewProtocol? {get set}
    var interactor: SearchResultScreenInputInteractorProtocol? {get set}
    var router: SearchResultScreenRouterProtocol? {get set}
    init(view: SearchResultScreenViewProtocol, interactor: SearchResultScreenInputInteractorProtocol, router: SearchResultScreenRouterProtocol)
    func searchImages(withKeyword keyword:String, withPageNum pageNum:Int)
    func didTapOnFilterButton()
}


protocol SearchResultScreenInputInteractorProtocol: class{
    var presenter: SearchResultScreenOutputInteractorProtocol? {get set}
    func fetchImagesFromServer(withKeyword keyword:String, withPageNum pageNum:Int)
}

protocol SearchResultScreenOutputInteractorProtocol: class{
    func didFetchImages(forPageNum pageNum:Int, andImages images:[ImageModel]?)
    func filterButtonStatus(toShow:Bool, imageToShow:UIImage?)
}

protocol SearchResultScreenRouterProtocol: class{
    func goToFilterScreen()
}
