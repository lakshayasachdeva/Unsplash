//
//  HomeScreenRouter.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation
import UIKit

class HomeScreenRouter: ImageScreenRouterProtocol{
   
    func goToFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol) {
        // navigate to full image screen...
        AppNavigationHandler.goToFullImageScreen(withSelectedImage: selectedImage, andFullImageUrl: imgUrl, presentFrom: viewRef)
    }
    
    
    func goToSearchScreen(presentFrom viewRef: ImagesScreenViewProtocol) {
        // navigate to search result screen
        AppNavigationHandler.goToSearchScreen(fromViewController: viewRef as! HomeViewController)
    }
    
    func goToFilterScreen(presentFrom viewRef: ImagesScreenViewProtocol) {
        AppNavigationHandler.goToAdvancedSearchScreen(fromViewController: viewRef as! SearchResultsViewController)
    }

    
}
