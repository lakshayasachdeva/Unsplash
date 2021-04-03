//
//  AdvancedSearchRouter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation
import UIKit


class SearchScreenRouter: SearchResultScreenRouterProtocol {
    
    func goToFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol) {
        // navigate to full image screen...
        AppNavigationHandler.goToFullImageScreen(withSelectedImage: selectedImage, andFullImageUrl: imgUrl, presentFrom: viewRef)
    }
    
    
    func goToFilterScreen(presentFrom viewRef: ImagesScreenViewProtocol) {
        // navigate to search result screen
        AppNavigationHandler.goToAdvancedSearchScreen(fromViewController: viewRef as! SearchResultsViewController)
    }
    

}
