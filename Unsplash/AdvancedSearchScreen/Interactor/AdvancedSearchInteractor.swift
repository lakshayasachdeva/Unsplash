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
        var newFilters = filters
        for i in 0..<newFilters[groupNum].items!.count{
            if i == itemIndex{
                newFilters[groupNum].items![i].isApplied = true
            } else{
                newFilters[groupNum].items![i].isApplied = false
            }
        }
        presenter?.didModifyFilters(filters: newFilters, forGroup: groupNum)
    }
    
    func resetAllFilters() {
        FilterModel.clearAllSavedFilters()
        let data = FilterModel.getDefaultFilters()
        presenter?.didResetFilters(filters: data)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.kUserDidApplyFilters), object: nil)
    }
    
    func saveAppliedFilters(withData filters: [FilterModel]) {
        FilterModel.saveFilters(items: filters)
        presenter?.didSaveFilters()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.kUserDidApplyFilters), object: nil)

    }
    
    
}
