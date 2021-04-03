//
//  AdvancedSearchProtocols.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation
import UIKit


protocol AdvancedSearchViewProtocol: class {
    var filtersTableView: UITableView! {get set}
    func registerNibs()
    var filters: [FilterModel]? {get set}
}


protocol AdvancedSearchPresenterProtocol: class {
    
}


protocol AdvancedSearchInputInteractorProtocol: class {
    
}


protocol AdvancedSearchOuputInteractorProtocol: class{
    
}


protocol AdvancedSearchRouterProtocol: class {
    
}
