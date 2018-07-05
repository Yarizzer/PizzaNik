//
//  CartTableViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 30/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {

    var viewModel: CartViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = CartViewModel()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        guard let model = viewModel else { return }
//        model.updateCartDataBase()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as? CartTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        tableViewCell.cellModel = viewModel.getCartCellViewModel(forIndexPath: indexPath)
        
        return tableViewCell

    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
       let delete = UITableViewRowAction(style: .normal, title: "Delete") { [unowned self] (action, IndexPath) in
            guard let model = self.viewModel else { return }
        
            model.removeItem(forIndexPath: indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .right)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
