//
//  AppConstants.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation
import UIKit


struct AppConstants {
    
    //TODO: Since it is a confidential data, so we should save it in keychain.
    static let kAccessKey = "FZpIl7feLseFHwV4DScQqiaVULO54C7GRBiqlmDrxdI"
    static let kSecretKey = "F91OpKAWUx6mSzdNVDKDf8SXgS4HwLzNTqGWMYkoOuE"
    
    
    
    static let kHomeScreenTitle = "Unsplash"
    static let kSearchViewHeaderHeight: CGFloat = 50.0
    static let kBaseURL = "https://api.unsplash.com"
    static let kCollectionPhotosURL = "\(AppConstants.kBaseURL)" + "/collections/2423569/photos"
    
    static let sortIcon = UIImage(named: "sortIcon")
    static let sortAppliedIcon = UIImage(named: "sortAppliedIcon")
    static let searchBarPlaceholderText = "Search images e.g. starwars"
    
    static let kSearchPhotosURL = "\(AppConstants.kBaseURL)" + "/search/photos"
    static let kEmptyRecordsMessage = "No records found! Try searching with different keyword e.g. Star wars"
    static let filterScreenTitle = "Filters"
    static let kAppliedFiltersKey = "appliedFilters"
    
    // Filters
    // Group-1  => Sort by
    static let group1Filter = FilterModel(queryParam: "order_by", sectionNum: 0,
                                          name: "Sort By",
                                          items: [FilterItem(name: "Relevance", value: "relevant", isApplied: true), FilterItem(name: "Newest", value: "latest", isApplied: false)])
    // Group-2  => Color
    static let group2Filter = FilterModel(queryParam: "color", sectionNum: 1,
                                          name: "Color",
                                          items: [FilterItem(name: "Any color", value: nil, isApplied: true), FilterItem(name: "Black and white", value: "black_and_white", isApplied: false)])
    
    // Group-3  => Orientation
    static let group3Filter = FilterModel(queryParam: "orientation",sectionNum: 2,
                                          name: "Orientation",
                                          items: [FilterItem(name: "Any", value: nil, isApplied: true),FilterItem(name: "Landscape", value: "landscape", isApplied: false), FilterItem(name: "Portrait", value: "portrait", isApplied: false), FilterItem(name: "Square", value: "squarish", isApplied: false)])

    static let kUserDidApplyFilters = "filtersAppliedByUser"
}




