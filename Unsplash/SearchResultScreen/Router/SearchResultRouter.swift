//
//  SearchResultRouter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 04/04/21.
//

import Foundation
import UIKit


class SearchResultsRouter: SearchResultScreenRouterProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController{
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
        let interactor = SearchResultInteractor()
        let wireframe = SearchResultsRouter()
        let presenter: SearchResultPresenter & SearchResultScreenOutputInteractorProtocol = SearchResultPresenter.init(view: view, interactor: interactor, router: wireframe)
        view.presenter = presenter
        view.presenter?.interactor?.presenter = presenter
        wireframe.viewController = view
        return view
    }
    
    func goToFilterScreen() {
        guard let view = viewController else {return}
        AppNavigationHandler.goToAdvancedSearchScreen(fromViewController: view)
    }
    
}
