//
//  ThirdScreenSecondSectionCellViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 10/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class ThirdScreenSecondSectionCellViewModel {
    private var itemIngredient: String?
    
    init(forIngredient ingredient: String) {
        self.itemIngredient = ingredient
    }
}

extension ThirdScreenSecondSectionCellViewModel: ThirdScreenSecondSectionCellType {
    var ingredient: String {
        guard let ingredient = itemIngredient else { return ""}
        return ingredient
    }

}
