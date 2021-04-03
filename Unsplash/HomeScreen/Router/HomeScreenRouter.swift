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
        let vc = FullScreenImageViewController.getFullScreenVC()
        vc.transitioningDelegate = viewRef
        vc.modalPresentationStyle = .fullScreen
        vc.setupWithPhoto(photo: selectedImage, andFullResImg: imgUrl)
        if let view = viewRef as? HomeViewController{
            view.present(vc, animated: true, completion: nil)
        }
    }
    
    

    
    
    
}
