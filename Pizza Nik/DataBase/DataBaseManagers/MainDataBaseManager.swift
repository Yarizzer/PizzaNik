//
//  DataBaseModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 17/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import CoreData

class MainDataBaseManager {
    static let shared = MainDataBaseManager()
    
    private init() {}
    
    var mainMenuItems = [MainMenuItem]()
    var menuItems = [MenuItem]()
    var cartItems = [Cart]()
    
    func runManagers() {
        CartManager.shared.run()
        MenuManager.shared.run()
        
        mainMenuItems = MenuManager.shared.getMainMenuItemsFromDataBase(withPriority: nil)
        menuItems = MenuManager.shared.getMenuItemsFromDataBase(forParentPriority: nil)
        cartItems = CartManager.shared.getCartItemsFromDataBase()
        
        print("Cart items count is \(cartItems.count)")
        print("Main menu items count is \(mainMenuItems.count)")
        print("menu items count is \(menuItems.count)")
        
    }
    
    func getMenuItems(forParentPriority parentIndex: Int16?) -> [MenuItem] {
        return MenuManager.shared.getMenuItemsFromDataBase(forParentPriority: parentIndex)
    }
    
    func addToCart(item: MenuItem, quantity: Int) {
        CartManager.shared.addToCart(item: item, quantity: quantity)
        cartItems = CartManager.shared.getCartItemsFromDataBase()
    }
    
    func removeFromCart(item: MenuItem) {
        CartManager.shared.removeFromCart(item: item)
        cartItems = CartManager.shared.getCartItemsFromDataBase()
    }
    func removeAllRecordsFromCart() {
        CartManager.shared.removeAllItems()
    }
    func updateCartData(with values: [Cart: Int]) {
        CartManager.shared.updateCart(forNewCartValues: values)
    }
    
}
