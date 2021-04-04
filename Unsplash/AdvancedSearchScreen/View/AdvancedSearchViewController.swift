//
//  AdvancedSearchViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import UIKit

class AdvancedSearchViewController: UIViewController, AdvancedSearchViewProtocol {
   
    
    // MARK:- IBOutlets
    @IBOutlet weak var filtersTableView: UITableView!{
        didSet{
            filtersTableView.contentInsetAdjustmentBehavior = .never
            filtersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0);
        }
    }
    @IBOutlet weak var cancelButton: UIButton!
    private var filters: [FilterModel]?
    var presenter: AdvancedSearchPresenterProtocol?
    
    class func getAdvancedSearchVC() -> AdvancedSearchViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdvancedSearchViewController") as! AdvancedSearchViewController
        return vc
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addClearAllButton()
        drawBorderOnCancelBtn()
        registerNibs()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setScreenTitle()
    }
    
    // MARK: UI setup methods
    func setScreenTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = AppConstants.filterScreenTitle
    }
    
    func registerNibs(){
        filtersTableView.register(FilterItemTableViewCell.cellNib, forCellReuseIdentifier: FilterItemTableViewCell.reuseIdentifier)
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
        presenter?.didSelectResetFilters()
    }
    
    @IBAction func handleCancelBtnTap(sender: UIButton){
        presenter?.didTapOnCancelButton()
    }
    
    @IBAction func handleApplyBtnTap(sender: UIButton){
        presenter?.didTapOnApplyButton(withAppliedFilter: self.filters ?? [FilterModel]())
    }
    
    // MARK: view data changes
    func showData(withFilters filters: [FilterModel]?) {
        self.filters = filters
        filtersTableView.reloadData()
    }
    
    func showModifiedData(withFitlerData data: [FilterModel]?, forGroup groupNum: Int) {
        self.filters = data
        reloadGroup(num: groupNum)
    }
    
    func reloadGroup(num: Int){
        self.filtersTableView.reloadSections(IndexSet(integer: num), with: .fade)
    }
   
    
}

// MARK: Tableview methods

extension AdvancedSearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterItemTableViewCell.reuseIdentifier, for: indexPath) as! FilterItemTableViewCell
        if let filterItem = filters?[indexPath.section]{
            cell.bindDataToView(forItem: filterItem.items?[indexPath.row], withGroupNum: indexPath.section, andWithItemNum: indexPath.row, andDelegate: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let filterItem = filters?[section]{
            return filterItem.name
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
}


// MARK: delegate methods
extension AdvancedSearchViewController: FilterItemSelectionProtocol{
    
    func didSelectFilter(withSelectedItem itemIndex: Int, withGroupNum groupNum: Int) {
        presenter?.didSelectFilter(withSelectedItem: itemIndex, withGroupNum: groupNum, andPreviousFilter: self.filters!)
    }
    
}
