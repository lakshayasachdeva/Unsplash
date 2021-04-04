//
//  GridImageesViewProtocol.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 04/04/21.
//

import Foundation
import UIKit

protocol GridImagesViewProtocol {
    var imagesCollectionView: UICollectionView! {
        get set
    }
    func showImages(withImageData data:[ImageModel]?)
    var currentPageIndex: Int{get}
}
