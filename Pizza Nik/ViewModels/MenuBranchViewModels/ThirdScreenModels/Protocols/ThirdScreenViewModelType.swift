//
//  ThirdScreenViewModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 10/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

protocol ThirdScreenViewModelType {
    var secondScreenItemName: String { get }
    var numberOfRowsFirstSection: Int { get }
    var numberOfRowsSecondSection: Int { get }
    func price() -> String
    func headerImage() -> UIImage
    func addToCart(quantity: Int)
    func getFirstSectionCellViewModel() -> ThirdScreenFirstSectionCellType?
    func getSecondSectionCellViewModel(forIndexPath indexpath: IndexPath) -> ThirdScreenSecondSectionCellType?
}
