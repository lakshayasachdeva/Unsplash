//
//  HomeScreenModule.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation

class HomeScreenModule {
    
    class func create(viewRef imagesListRef: HomeViewController){
        let presenter: ImagesScreenPresenterProtocol & ImageScreenOutputInteractorOutputProtocol = HomeScreenPresenter()
        imagesListRef.presenter = presenter
        imagesListRef.presenter?.wireframe = HomeScreenRouter()
        imagesListRef.presenter?.view = imagesListRef
        imagesListRef.presenter?.interactor = HomeScreenInteractor()
        imagesListRef.presenter?.interactor?.presenter = presenter
    }

}
