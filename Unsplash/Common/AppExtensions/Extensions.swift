//
//  Extensions.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 04/04/21.
//

import Foundation
import UIKit


extension UICollectionView {
    // This is to set empty message when there is no data to show
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 30.0, y: 0, width: self.bounds.size.width - 60.0, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Avenir Next", size: 20.0)!
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
