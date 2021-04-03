//
//  AdvancedSearchModule.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation

class AdvancedSearchModule {
    
    class func create(viewRef filterViewRef: AdvancedSearchViewController){
        let presenter: AdvancedSearchPresenterProtocol & AdvancedSearchOuputInteractorProtocol = AdvancedSearchPresenter()
        filterViewRef.presenter = presenter
        filterViewRef.presenter?.wireframe = AdvancedSearchRouter()
        filterViewRef.presenter?.view = filterViewRef
        filterViewRef.presenter?.interactor = AdvancedSearchInteractor()
        filterViewRef.presenter?.interactor?.presenter = presenter
    }

}
