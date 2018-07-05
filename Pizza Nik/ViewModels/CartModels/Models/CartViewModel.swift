//
//  CartViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 14/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class CartViewModel {
    private var items: [Cart]
    private var selectedIndexPath: IndexPath?
    
    init() {
        self.items = MainDataBaseManager.shared.cartItems
    }
}

extension CartViewModel: CartViewModelType {
    
    var numberOfRows: Int {
        return items.count
    }
    
    func removeItem(forIndexPath indexPath: IndexPath) {
        let cartItem = self.items.remove(at: indexPath.row)
        MainDataBaseManager.shared.removeFromCart(item: cartItem.menuItem)
    }
    
    func setSelectedIndexPath(forIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func getCartCellViewModel(forIndexPath indexPath: IndexPath) -> CartCellViewModelType? {
        return CartCellViewModel(forItem: items[indexPath.row], with: self)
    }
    
    func updateCartItemsArray(for item: MenuItem, with value: Int) {
        print("this metod multipies values in cart")
        for i in items {
            if i.menuItem == item {
                i.quantity = Int16(value)
                MainDataBaseManager.shared.addToCart(item: i.menuItem, quantity: Int(i.quantity))
            }
        }
    }
    
//    func updateCartDataBase() {
////        MainDataBaseManager.shared.removeAllRecordsFromCart()
//        var dict = [Cart: Int]()
//        for
//        MainDataBaseManager.shared.updateCartData(with: <#T##[Cart : Int]#>)
//    }
    
}
