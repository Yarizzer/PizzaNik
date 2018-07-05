//
//  ThirdScreenViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 10/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class ThirdScreenViewModel {
    private var secondScreenItem: MenuItem
    private var ingredients: [String] {
        guard let arrayOfIngredients = secondScreenItem.ingredients as? Array<String> else { return [String]() }
        return arrayOfIngredients
    }
    init(forItem item: MenuItem) {
        self.secondScreenItem = item
    }
}

extension ThirdScreenViewModel: ThirdScreenViewModelType {

    var numberOfRowsFirstSection: Int {
        return 1
    }
    var numberOfRowsSecondSection: Int {
        guard let ingredients = secondScreenItem.ingredients as? Array<String> else { return 0 }
        return ingredients.count
    }
    
    var secondScreenItemName: String {
        guard let itemName = secondScreenItem.itemName else { return ""}
        return itemName
    }
    
    func price() -> String {
        return "\(secondScreenItem.itemPrice)"
    }
    
    func headerImage() -> UIImage {
        guard let itemImage = UIImage(data: secondScreenItem.itemImage! as Data) else { return UIImage(named: "TabBarMenuImage-iphone")! }
        return itemImage
    }
    
    func addToCart(quantity: Int) {
        MainDataBaseManager.shared.addToCart(item: secondScreenItem, quantity: quantity)
    }
    
    func getFirstSectionCellViewModel() -> ThirdScreenFirstSectionCellType? {
        return ThirdScreenFirstSectionCellViewModel(forItem: secondScreenItem)
    }
    
    func getSecondSectionCellViewModel(forIndexPath indexPath: IndexPath) -> ThirdScreenSecondSectionCellType? {
        guard !ingredients.isEmpty else { return nil }
        
        return ThirdScreenSecondSectionCellViewModel(forIngredient: ingredients[indexPath.row])
    }
}
