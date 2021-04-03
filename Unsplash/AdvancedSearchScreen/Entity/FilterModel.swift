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
    
}


struct FilterItem:Codable {
    let name: String!
    let value: String?
    var isApplied: Bool!
}
