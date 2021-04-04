//
//  HomeScreenProtocols.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation
import UIKit


protocol HomeScreenViewProtocol: class, GridImagesViewProtocol {
    var presenter: HomeScreenPresenterProtocol? {get set}
   // func setFilterIconVisibility(toBeShown status:Bool, withIamge image:UIImage?)
}


protocol HomeScreenPresenterProtocol: class {
    var view: HomeScreenViewProtocol? {get set}
    var interactor: HomeScreenInputInteractorProtocol? {get set}
    var wireframe: HomeScreenRouterProtocol? {get set}
    init(view: HomeScreenViewProtocol, interactor: HomeScreenInputInteractorProtocol, router: HomeScreenRouterProtocol)
    func viewDidLoad()
    func getImages(forPageNum pageNum: Int)
    func didTapOnSearchView()
}


protocol HomeScreenInputInteractorProtocol: class{
    var presenter: HomeScreenOutputInteractorProtocol? {get set}
    func fetchImagesFromServer(forPageNum pageNum:Int)
}

protocol HomeScreenOutputInteractorProtocol: class{
    func didFetchImages(forPageNum pageNum:Int, andImages images:[ImageModel]?)
}

protocol HomeScreenRouterProtocol: class{
    func goToSearchScreen()
}

