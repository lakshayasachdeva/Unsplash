//
//  SearchResultModule.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation

class SearchResultScreenModule{
    
    class func create(viewRef searchResultListRef: SearchResultsViewController){
        let presenter: ImagesScreenPresenterProtocol & ImageScreenOutputInteractorOutputProtocol = HomeScreenPresenter()
        searchResultListRef.presenter = presenter
        searchResultListRef.presenter?.wireframe = HomeScreenRouter()
        searchResultListRef.presenter?.view = searchResultListRef
        searchResultListRef.presenter?.interactor = HomeScreenInteractor()
        searchResultListRef.presenter?.interactor?.presenter = presenter
    }

}
