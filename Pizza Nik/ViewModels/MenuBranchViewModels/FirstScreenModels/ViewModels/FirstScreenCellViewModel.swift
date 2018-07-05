//
//  MainMenuCellViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 06/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class FirstScreenCellViewModel {
    
    private var item: MainMenuItem
    
    init(forItem item: MainMenuItem) {
        self.item = item
    }
}

extension FirstScreenCellViewModel: FirstScreenCellViewModelType {
    var itemName: String {
        guard let itemName = item.name else { return "Name is not set."}
        return itemName
    }
    
    var itemImage: UIImage {
        guard let itemImage = UIImage(data: item.image! as Data) else { return UIImage(named: "TabBarMenuImage-iphone")! }
        return itemImage
    }
    
    var itemOrder: Int {
        return Int(item.priority)
    }
    
    func getSecondScreenViewModel() -> SecondScreenViewModelType? {
        return SecondScreenViewModel(forItem: item)
    }
    
}
