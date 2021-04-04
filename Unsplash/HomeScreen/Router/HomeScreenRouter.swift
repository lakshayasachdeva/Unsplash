//
//  HomeScreenRouter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//


import Foundation
import UIKit

class HomeScreenRouter: HomeScreenRouterProtocol{
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController{
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let interactor = HomeScreenInteractor()
        let wireframe = HomeScreenRouter()
        let presenter: HomeScreenPresenterProtocol & HomeScreenOutputInteractorProtocol = HomeScreenPresenter.init(view: view, interactor: interactor, router: wireframe)
        view.presenter = presenter
        view.presenter?.interactor?.presenter = presenter
        wireframe.viewController = view
        return view
    }
    
    
    func goToSearchScreen() {
        guard let view = viewController else {return}
        AppNavigationHandler.goToSearchScreen(fromViewController: view)
    }
    
}




