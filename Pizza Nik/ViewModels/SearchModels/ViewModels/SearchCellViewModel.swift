//
//  SearchCellViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 27/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class SearchCellViewModel {
    private var item: MenuItem
    
    init(forItem item: MenuItem) {
        self.item = item
    }
    
}

extension SearchCellViewModel: SearchCellModelType {
    var itemImage: UIImage {
        guard let itemImage = UIImage(data: item.itemImage! as Data) else { return UIImage(named: "TabBarMenuImage-iphone")! }
        return itemImage
    }
    
    var itemGroup: String {
        guard let groupName = item.mainMenuItems?.name else { return "" }
        return groupName
    }
    
    var itemName: String {
        guard let name = item.itemName else { return "" }
        return name
    }
    

    
    
}
