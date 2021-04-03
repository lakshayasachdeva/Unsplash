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
    func showData(withFilters filters: [FilterModel]?)
    func showModifiedData(withFitlerData data:[FilterModel]?, forGroup groupNum: Int)
    var presenter: AdvancedSearchPresenterProtocol? {get set}
    func didApplyFilters()
}


protocol AdvancedSearchPresenterProtocol: class {
    var view: AdvancedSearchViewProtocol? {get set}
    var interactor: AdvancedSearchInputInteractorProtocol? {get set}
    var wireframe: AdvancedSearchRouterProtocol? {get set}
    func viewDidLoad()
    func didTapOnCancelButton()
    func didTapOnApplyButton(withAppliedFilter filters: [FilterModel])
    func didSelectFilter(withSelectedItem itemIndex: Int, withGroupNum groupNum: Int, andPreviousFilter filters: [FilterModel])
    func didSelectResetFilters()
}


protocol AdvancedSearchInputInteractorProtocol: class {
    var presenter: AdvancedSearchOuputInteractorProtocol? {get set}
    func fetchSavedFilters()
    func modifyFilters(withChangedItem itemIndex: Int, forGroup groupNum: Int, toCurrentFilter filters: [FilterModel])
    func resetAllFilters()
    func saveAppliedFilters(withData filters:[FilterModel])
}


protocol AdvancedSearchOuputInteractorProtocol: class{
    func didFetchSavedFilters(withFilters filters: [FilterModel]?)
    func didModifyFilters(filters data:[FilterModel]?, forGroup group:Int)
    func didResetFilters(filters data: [FilterModel]?)
    func didSaveFilters()
}


protocol AdvancedSearchRouterProtocol: class {
    func popToPreviousScreen()
}