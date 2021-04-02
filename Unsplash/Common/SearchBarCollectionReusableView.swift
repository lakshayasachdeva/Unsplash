//
//  SearchBarCollectionReusableView.swift
//  CLTest
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import UIKit


protocol SearchHeaderViewProtocol {
    func didTapOnView()
}

class SearchBarCollectionReusableView: UICollectionReusableView {
    
    static let cellNib = UINib(nibName: "SearchBarCollectionReusableView", bundle: nil)
    static let reuseIdentifier = "SearchBarCollectionReusableView"
    var delegate: SearchHeaderViewProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnView))
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapOnView(){
        delegate?.didTapOnView()
    }
    
}
