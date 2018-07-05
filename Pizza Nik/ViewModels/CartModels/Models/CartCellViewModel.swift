//
//  CartCellViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 14/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class CartCellViewModel {
    private var item: Cart
    private var itemPrice: Int
    private var cartModel: CartViewModelType
    init(forItem item: Cart, with model: CartViewModelType) {
        self.item = item
        self.itemPrice = Int(item.menuItem.itemPrice)
        self.cartModel = model
    }
}

extension CartCellViewModel: CartCellViewModelType {
    
    var itemName: String {
        guard let itemName = item.menuItem.itemName else { return "item name not set" }
        return itemName
    }
    
    var itemGroup: String {
        guard let groupName = item.menuItem.mainMenuItems?.name else { return "group name not set" }
        return groupName
    }
    
    var quantity: Int {
        let quantity = Int(item.quantity)
        return quantity
    }
    
    func updateSummary(withValue value: Int) -> String {
//        cartModel.updateCartItemsArray(for: item.menuItem, with: value)
        print("updating sum")
        return "\(value * itemPrice)"
    }
    
    func itemImage() -> UIImage {
        let defImage = UIImage(named: "VYbQ-dN_cfo-iphone")!
        guard let itemImage = UIImage(data: item.menuItem.itemImage! as Data) else { return defImage }
        return itemImage
    }
    
    
}
