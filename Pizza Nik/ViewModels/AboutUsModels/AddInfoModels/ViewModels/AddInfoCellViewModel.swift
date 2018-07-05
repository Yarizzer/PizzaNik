//
//  AddInfoCellViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 13/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class AddInfoCellViewModel {
    private var itemName: String
    init(itemName: String) {
        self.itemName = itemName
    }
}

extension AddInfoCellViewModel: AddInfoCellViewType{
    var categoryName: String {
        return itemName
    }
}
