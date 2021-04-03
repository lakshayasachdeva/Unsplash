//
//  AdvancedSearchRouter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation


class AdvancedSearchRouter: AdvancedSearchRouterProtocol{
    
    func popToPreviousScreen(fromScreen screen: AdvancedSearchViewController) {
        screen.navigationController?.popViewController(animated: true)
    }
    
}
