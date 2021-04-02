//
//  HomeScreenProtocols.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation
import UIKit


protocol ImageScreenProtocol {
    var imagesCollectionView: UICollectionView! {
        get set
    }
    func registerCollectionViewCellNibs()
}
