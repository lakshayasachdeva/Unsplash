//
//  AdvancedSearchInteractor.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation

class AdvancedSearchInteractor: AdvancedSearchInputInteractorProtocol{
    
    weak var presenter: AdvancedSearchOuputInteractorProtocol?
    
    func fetchSavedFilters() {
        let filters = FilterModel.getFilters()
        presenter?.didFetchSavedFilters(withFilters: filters)
    }
    
    
    func modifyFilters(withChangedItem itemIndex: Int, forGroup groupNum: Int, toCurrentFilter filters: [FilterModel]){
        var cuurentFilters = filters
        for i in 0..<cuurentFilters[groupNum].items!.count{
            if i == itemIndex{
                cuurentFilters[groupNum].items![i].isApplied = true
            } else{
                cuurentFilters[groupNum].items![i].isApplied = false
            }
        }
        presenter?.didModifyFilters(filters: cuurentFilters, forGroup: groupNum)
    }
    
    func resetAllFilters() {
        FilterModel.clearAllSavedFilters()
        let data = FilterModel.getDefaultFilters()
        presenter?.didResetFilters(filters: data)
    }
    
    func saveAppliedFilters(withData filters: [FilterModel]) {
        FilterModel.saveFilters(items: filters)
        presenter?.didSaveFilters()
    }
    
    
}
