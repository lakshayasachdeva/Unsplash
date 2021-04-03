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
    static let kCollectionPhotosURL = "\(AppConstants.kBaseURL)" + "/collections/1410291/photos"
    
    static let sortIcon = UIImage(named: "sortIcon")
    static let sortAppliedIcon = UIImage(named: "sortAppliedIcon")
    static let searchBarPlaceholderText = "Search images e.g. starwars"
    
    static let kSearchPhotosURL = "\(AppConstants.kBaseURL)" + "/search/photos"
    
}



