//
//  ViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 22/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var screenViewModel: ThirdScreenViewModelType?
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var decreaseButton: IncreaseDecreaseButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBAction func decreaseAction(_ sender: IncreaseDecreaseButton) {
        quantityLabel.text = "\(Int(quantityLabel.text!)! - 1)"
        if quantityLabel.text == "1" { decreaseButton.isEnabled = false }
        
        guard let model = screenViewModel else { return }
        priceLabel.text = "\(Int(model.price())! * Int(quantityLabel.text!)!)"
    }
    @IBAction func increaseAction(_ sender: IncreaseDecreaseButton) {
        quantityLabel.text = "\(Int(quantityLabel.text!)! + 1)"
        decreaseButton.isEnabled = true
        
        guard let model = screenViewModel else { return }
        priceLabel.text = "\(Int(model.price())! * Int(quantityLabel.text!)!)"
    }
    
    @IBAction func addToCart(_ sender: AddToCartButton) {
        let quantity = Int(quantityLabel.text!)!
        guard let model = screenViewModel else { return }
        model.addToCart(quantity: quantity)

    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = screenViewModel else { return }
        self.navigationItem.title = model.secondScreenItemName
        itemImage.image = model.headerImage()
        priceLabel.text = model.price()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Ингредиенты"
        } else {
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            guard let model = screenViewModel else { return 0 }
            return model.numberOfRowsFirstSection
        } else {
            guard let model = screenViewModel else { return 0 }
            return model.numberOfRowsSecondSection
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailOverviewCell", for: indexPath) as? FirstSectionTableViewCell
            
            guard let tableViewCell = cell, let model = screenViewModel else { return UITableViewCell() }
            
            tableViewCell.thirdScreenFirstSectionCellViewModel = model.getFirstSectionCellViewModel()
            return tableViewCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailIngredientsCell", for: indexPath) as? SecondSectionTableViewCell
            guard let tableViewCell = cell, let model = screenViewModel else { return UITableViewCell() }
            
            tableViewCell.thirdScreenSecondSectionCellViewModel = model.getSecondSectionCellViewModel(forIndexPath: indexPath)
            return tableViewCell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
