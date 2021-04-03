//
//  AppNavigationHandler.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation
import UIKit

class AppNavigationHandler{
    
    static func removeBackButtonTitle(from: UIViewController?) {
        let emptyBackButton = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        from?.navigationController?.navigationBar.topItem?.backBarButtonItem = emptyBackButton
    }
    
    static func goToSearchScreen(fromViewController viewRef: UIViewController){
        let vc = SearchResultsViewController.getSearchResultVC()
        removeBackButtonTitle(from: viewRef)
        viewRef.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol){
        let vc = FullScreenImageViewController.getFullScreenVC()
        vc.transitioningDelegate = viewRef
        vc.modalPresentationStyle = .fullScreen
        vc.setupWithPhoto(photo: selectedImage, andFullResImg: imgUrl)
        if let view = viewRef as? HomeViewController{
            view.present(vc, animated: true, completion: nil)
        }
    }
    
    static func goToAdvancedSearchScreen(fromViewController viewRef: UIViewController){
        let vc = AdvancedSearchViewController.getAdvancedSearchVC()
        removeBackButtonTitle(from: viewRef)
        viewRef.navigationController?.pushViewController(vc, animated: true)
    }
    
}
