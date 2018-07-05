//
//  ThirdScreenFirstSectionCellViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 10/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class ThirdScreenFirstSectionCellViewModel {
    private var item: MenuItem?
    
    init(forItem item: MenuItem) {
        self.item = item
    }
}

extension ThirdScreenFirstSectionCellViewModel: ThirdScreenFirstSectionCellType {
    var discription: String {
        guard let itemDiscription = item?.itemDiscription else { return "" }
        return itemDiscription
    }
}
