//
//  DetailInfoViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 13/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class DetailInfoViewModel {
    private var detailText: String?
    private var categoryName: String?
    
    init(shosenCategoryName: String, detailText text: String) {
        self.detailText = text
        self.categoryName = shosenCategoryName
    }
}

extension DetailInfoViewModel: DetailInfoViewType {
    func getDetailText() -> String? {
        guard let detailText = detailText else { return ""}
        return detailText
    }
    
    func getCategoryName() -> String? {
        guard let catName = categoryName else { return "" }
        return catName
    }
}
