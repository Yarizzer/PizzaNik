//
//  MenuViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 06/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class SecondScreenViewModel {
    
    private var firstScreenItem: MainMenuItem
    private var items: [MenuItem]
    private var selectedIndexPath: IndexPath?
    

    init(forItem item: MainMenuItem) {
        self.firstScreenItem = item
        self.items = MainDataBaseManager.shared.getMenuItems(forParentPriority: Int16(firstScreenItem.priority))
    }
}

extension SecondScreenViewModel: SecondScreenViewModelType {

    var numberOfRows: Int {
        return items.count
    }
    
    var firstScreenItemName: String {
        guard let itemName = firstScreenItem.name else { return ""}
        return itemName
    }

    func headerImage() -> UIImage {
        guard let itemImage = UIImage(data: firstScreenItem.image! as Data) else { return UIImage(named: "TabBarMenuImage-iphone")! }
        return itemImage
    }
    
    func selectedIndexPath(forIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func getCellViewModel(forIndexPath indexPath: IndexPath) -> SecondScreenCellViewModelType? {
        return SecondScreenCellViewModel(forItem: items[indexPath.row])
    }
    
    func getThirdScreenViewModelForSelectedRow() -> ThirdScreenViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return ThirdScreenViewModel(forItem: items[selectedIndexPath.row])
    }
    
}
