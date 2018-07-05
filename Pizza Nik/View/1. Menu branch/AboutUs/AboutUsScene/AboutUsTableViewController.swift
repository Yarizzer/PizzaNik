//
//  AboutUsTableViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 28/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class AboutUsTableViewController: UITableViewController {

    private var viewModel: AddInfoModelType?
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = AddInfoViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AboutUsTableViewCell

        guard let tableViewCell = cell, let model = viewModel else { return UITableViewCell() }
        
        tableViewCell.cellModel = model.getInfoCellModel(forIndexPath: indexPath)

        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let viewModel = viewModel else { return }
        viewModel.setSelectedIndexPath(forIndexPath: indexPath)
        
        let cell = tableView.cellForRow(at: indexPath) as! AboutUsTableViewCell
        if cell.aboutUsLabel.text == "Кафе" {
            performSegue(withIdentifier: "cafeSegue", sender: self)
        } else {
            performSegue(withIdentifier: "detailInfoSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        if identifier == "detailInfoSegue" {
            if let destinationVC = segue.destination as? DetailInfoViewController {
                
                destinationVC.viewModel = viewModel.getScreenForDetailInfoForSelectedRow()
            }
            
        }
    }


  

}
