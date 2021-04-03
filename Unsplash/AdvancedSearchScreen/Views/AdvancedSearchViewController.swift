//
//  AdvancedSearchViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import UIKit

class AdvancedSearchViewController: UIViewController {
    
    @IBOutlet weak var filtersTableView: UITableView!{
        didSet{
            filtersTableView.register(FilterItemTableViewCell.cellNib, forCellReuseIdentifier: FilterItemTableViewCell.reuseIdentifier)
            filtersTableView.contentInsetAdjustmentBehavior = .never
            filtersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0);
        }
    }
    
    class func getSearchResultVC() -> AdvancedSearchViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdvancedSearchViewController") as! AdvancedSearchViewController
        return vc
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addClearAllButton()
        drawBorderOnCancelBtn()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setScreenTitle()
    }
    
    
    func setScreenTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = AppConstants.filterScreenTitle
    }
    
    
    func addClearAllButton(){
        let clearBtn = UIBarButtonItem(title: "Reset filters", style: .plain, target: self, action:#selector(handleClearBtnTap))
        self.navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = clearBtn
    }
    
    func drawBorderOnCancelBtn(){
        cancelButton.layer.borderColor = cancelButton.tintColor.cgColor
    }
    
    // MARK: Action methods
    @objc func handleClearBtnTap(){
    }
    
    @IBAction func handleCancelBtnTap(sender: UIButton){
        
    }
    
    @IBAction func handleApplyBtnTap(sender: UIButton){
        
    }
    
}


