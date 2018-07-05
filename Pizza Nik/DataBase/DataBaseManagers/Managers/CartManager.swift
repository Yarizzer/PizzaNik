//
//  CartManager.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 04/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CartManager {
    static let shared = CartManager()

    //filling Cart from dataBase
    func getCartItemsFromDataBase() -> [Cart] {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        
        var arrayToReturn = [Cart]()
        do {
            let arrayOfElementsInDataBase = try context.fetch(fetchRequest)
            guard !arrayOfElementsInDataBase.isEmpty else { return arrayToReturn }
            arrayToReturn = arrayOfElementsInDataBase.sorted {$0.order < $1.order }
        } catch {
            print(error.localizedDescription)
        }
        
        return arrayToReturn
    }
    
    func addToCart(item: MenuItem, quantity: Int) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "menuItem = %@", item)

        do {
            let result = try context.fetch(fetchRequest)
            if result.count > 0 {
                let record = result[0] as Cart
                let apdatedQuantity = record.quantity + Int16(quantity)
                record.setValue(apdatedQuantity, forKey: "quantity")
            } else {
                //creating a new entity
                let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context)
                let cartObject = NSManagedObject(entity: entity!, insertInto: context) as! Cart
                cartObject.menuItem = item
                let allItemsFetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
                let allRec = try context.fetch(allItemsFetchRequest)
                cartObject.order = Int16(allRec.count.advanced(by: 1))
                cartObject.quantity = Int16(quantity)
            }
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func alternativeAddToCart(item: MenuItem, quantity: Int) {
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "menuItem = %@", item)
//
//        var result = [Cart]()
//
//        do {
//            result = try context.fetch(fetchRequest)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        if result.count != 0 {
//            result[0].quantity += Int16(quantity)
//            do {
//                try
//                    context.save()
//            } catch {
//                print(error.localizedDescription)
//            }
//        } else {
//            let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context)
//            let cartObject = NSManagedObject(entity: entity!, insertInto: context) as! Cart
//            cartObject.menuItem = item
//            let cartArrayCount = cartItems.count
//            cartObject.order = Int16(cartArrayCount + 1)
//            cartObject.quantity = Int16(quantity)
//
//            do {
//                try
//                    context.save()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func removeFromCart(item: MenuItem) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "menuItem = %@", item)
        
        do {
            
            for item in try context.fetch(fetchRequest) {
                context.delete(item)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //removing all records from dataBase
    func removeAllCartItemsFromDataBase() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let cartFetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        
        do {
            for item in try context.fetch(cartFetchRequest) {
                context.delete(item)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }

    }
    
    //updating cart from cartModel
    func updateCart(forNewCartValues newCartValues: [Cart: Int]) {
        removeAllItems()
        for i in newCartValues {
            addToCart(item: i.key.menuItem, quantity: i.value)
        }
    }
    
    private init() {}
}

extension CartManager: DataBaseManageble {
    func run() {
        print("Cart manager starts...")
        removeAllItems()
    }
    
    func removeAllItems() {
        removeAllCartItemsFromDataBase()
    }
}
