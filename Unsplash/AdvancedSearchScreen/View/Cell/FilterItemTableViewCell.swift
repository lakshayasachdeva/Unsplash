//
//  FitlerCellTableViewCell.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import UIKit

protocol FilterItemSelectionProtocol: class {
    func didSelectFilter(withSelectedItem itemIndex: Int, withGroupNum groupNum: Int)
}

class FilterItemTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FilterItemTableViewCell"
    static let cellNib = UINib(nibName: "FilterItemTableViewCell", bundle: nil)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkboxBtn: UIButton!

    var itemNum: Int!
    var groupNum: Int!
    weak var delegate: FilterItemSelectionProtocol?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    
    func bindDataToView(forItem item: FilterItem?, withGroupNum num:Int, andWithItemNum itemNum:Int, andDelegate delegate: FilterItemSelectionProtocol){
        self.delegate = delegate
        groupNum = num
        self.itemNum = itemNum
        nameLabel.text = item?.name
        checkboxBtn.isSelected = item?.isApplied ?? false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func handleCheckboxBtnTap(sender: UIButton){
        let button = sender
        if button.isSelected == false{
            button.isSelected = !button.isSelected
            delegate?.didSelectFilter(withSelectedItem: self.itemNum, withGroupNum: self.groupNum)
        }
    }
}
