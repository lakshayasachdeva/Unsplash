//
//  AdvancedSearchPresenter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation

class AdvancedSearchPresenter: AdvancedSearchPresenterProtocol, AdvancedSearchOuputInteractorProtocol {
   
    
    
    
    var view: AdvancedSearchViewProtocol?
    var interactor: AdvancedSearchInputInteractorProtocol?
    var wireframe: AdvancedSearchRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchSavedFilters()
    }
    
    func didTapOnCancelButton() {
        
    }
    
    func didFetchSavedFilters(withFilters filters: [FilterModel]?) {
        view?.showData(withFilters: filters)
    }
    
    func didSelectFilter(withSelectedItem itemIndex: Int, withGroupNum groupNum: Int, andPreviousFilter filters: [FilterModel]) {
        interactor?.modifyFilters(withChangedItem: itemIndex, forGroup: groupNum, toCurrentFilter: filters)
    }
    
    func didModifyFilters(filters data: [FilterModel]?, forGroup group: Int) {
        view?.showModifiedData(withFitlerData: data, forGroup: group)
    }
    
    func didSelectResetFilters() {
        interactor?.resetAllFilters()
    }
    
    func didResetFilters(filters data: [FilterModel]?) {
        view?.showData(withFilters: data)
    }
    
    func didTapOnApplyButton(withAppliedFilter filters: [FilterModel]) {
        interactor?.saveAppliedFilters(withData: filters)
    }
    
    func didSaveFilters() {
        view?.didApplyFilters()
    }
    
}
