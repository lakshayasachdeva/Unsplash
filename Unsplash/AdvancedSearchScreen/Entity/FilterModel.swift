//
//  FilterModel.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation


struct FilterModel: Codable, Equatable {
    
    static func == (lhs: FilterModel, rhs: FilterModel) -> Bool {
        let group = lhs.sectionNum == rhs.sectionNum
        var isItemsEqual = true
        for i in 0..<lhs.items!.count{
            if lhs.items![i].isApplied != rhs.items![i].isApplied{
                isItemsEqual = false
                break
            }
        }
        return (group && isItemsEqual)
    }
    let queryParam:String?
    let sectionNum:Int?
    let name:String?
    var items: [FilterItem]?
    
    static func getFilters() -> [FilterModel]? {
        if let data = UserDefaults.standard.value(forKey:AppConstants.kAppliedFiltersKey) as? Data {
            let filters = try? PropertyListDecoder().decode(Array<FilterModel>.self, from: data)
            return filters
        } else{
            return FilterModel.getDefaultFilters()
        }
    }
    
    static func saveFilters(items: [FilterModel]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(items), forKey: AppConstants.kAppliedFiltersKey)
    }
    
    static func getDefaultFilters() -> [FilterModel]?{
        return [AppConstants.group1Filter, AppConstants.group2Filter, AppConstants.group3Filter]
    }
    
    static func clearAllSavedFilters() {
        UserDefaults.standard.set(nil, forKey: AppConstants.kAppliedFiltersKey)
    }
    
}


struct FilterItem:Codable {
    let name: String!
    let value: String?
    var isApplied: Bool!
}
