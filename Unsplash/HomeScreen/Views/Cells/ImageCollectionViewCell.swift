//
//  ImageCollectionViewCell.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let cellNib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    static let reuseIdentifier = "ImageCollectionViewCell"
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
