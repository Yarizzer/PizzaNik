//
//  MenuCellViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 09/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class SecondScreenCellViewModel {
    private var item: MenuItem
    
    init(forItem item: MenuItem) {
        self.item = item
    }
}

extension SecondScreenCellViewModel: SecondScreenCellViewModelType {
    
    var itemName: String {
        guard let itemName = item.itemName else { return "Name is not set."}
        return itemName
    }
    
    var itemDiscription: String {
        guard let itemDiscription = item.itemDiscription else { return "Discription is not set." }
        return itemDiscription
    }
    
    func itemPrice() -> String {
        return "\(item.itemPrice) ₽"
    }
    
    func itemImage() -> UIImage? {
        guard let itemImage = UIImage(data: item.itemImage! as Data) else { return UIImage(named: "TabBarMenuImage-iphone")! }
        return itemImage
    }
    
    func getTextForDiscussAcition() -> String {
        return "Как тебе такой выбор? \(itemName)"
    }
    
    func addToCart() {
        MainDataBaseManager.shared.addToCart(item: item, quantity: 1)
    }
}
