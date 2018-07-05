//
//  MenuTableViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 21/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var screenViewModel: SecondScreenViewModelType?
    
    @IBOutlet weak var manuHeaderImage: UIImageView!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.view.bounds
//        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth] //needs for left-right rotation position apps
//        self.view.insertSubview(blurEffectView, at: 1)
        
        guard let model = screenViewModel else { return }
        
        manuHeaderImage.image = model.headerImage()
        self.navigationItem.title = model.firstScreenItemName
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = screenViewModel else { return 0 }
        return model.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MenuTableViewCell
        
        guard let tableViewCell = cell, let model = screenViewModel else { return UITableViewCell() }
        
        tableViewCell.secondScreenCellViewModel = model.getCellViewModel(forIndexPath: indexPath)
        
        return tableViewCell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let viewModel = screenViewModel else { return }
        viewModel.selectedIndexPath(forIndexPath: indexPath)
        
        performSegue(withIdentifier: "showItemDetail", sender: nil)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let discuss = UITableViewRowAction(style: .default, title: "Обсудить") { [unowned self] (action, IndexPath) in

            guard let cell = self.screenViewModel?.getCellViewModel(forIndexPath: indexPath) else { return }
            if let image = cell.itemImage() {
                let activityController = UIActivityViewController(activityItems: [cell.getTextForDiscussAcition(), image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        let addToCart = UITableViewRowAction(style: .normal, title: "Добавить в корзину") { [unowned self] (action, IndexPath) in
            guard let cell = self.screenViewModel?.getCellViewModel(forIndexPath: indexPath) else { return }
            cell.addToCart()
        }
        
        discuss.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.7764705882, blue: 0.03921568627, alpha: 1)
        addToCart.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        return [addToCart, discuss]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let model = screenViewModel else { return }
        if identifier == "showItemDetail" {
            if let dvc = segue.destination as? DetailViewController {
                dvc.screenViewModel = model.getThirdScreenViewModelForSelectedRow()
            }
        }
    }

}
