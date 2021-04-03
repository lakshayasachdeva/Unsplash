//
//  AdvancedSearchProtocols.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 01/04/21.
//

import Foundation
import UIKit

// Router
protocol SearchResultScreenRouterProtocol: class {
    func goToFullImageScreen(withSelectedImage selectedImage: UIImage, andFullImageUrl imgUrl:String, presentFrom viewRef: ImagesScreenViewProtocol)
    func goToFilterScreen(presentFrom viewRef: ImagesScreenViewProtocol)
}
