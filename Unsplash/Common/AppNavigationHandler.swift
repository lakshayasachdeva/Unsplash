//
//  AppNavigationHandler.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation
import UIKit

class AppNavigationHandler{
    
    static func removeBackButtonTitle(from: UIViewController?) {
        let emptyBackButton = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        from?.navigationController?.navigationBar.topItem?.backBarButtonItem = emptyBackButton
    }
    
    static func goToSearchScreen(fromViewController viewRef: UIViewController){
        let vc = SearchResultsViewController.getSearchResultVC()
        removeBackButtonTitle(from: viewRef)
        viewRef.navigationController?.pushViewController(vc, animated: true)
    }
    
}
