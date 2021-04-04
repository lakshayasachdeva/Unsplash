//
//  AdvancedSearchRouter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation
import UIKit


class AdvancedSearchRouter: AdvancedSearchRouterProtocol{
   
    
    
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController{
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdvancedSearchViewController") as! AdvancedSearchViewController
        let interactor = AdvancedSearchInteractor()
        let wireframe = AdvancedSearchRouter()
        
        let presenter: AdvancedSearchPresenterProtocol & AdvancedSearchOuputInteractorProtocol = AdvancedSearchPresenter.init(view: view, interactor: interactor, wireframe: wireframe)
        view.presenter = presenter
        view.presenter?.interactor?.presenter = presenter
        wireframe.viewController = view
        return view
    }
    
    func popToPreviousScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
