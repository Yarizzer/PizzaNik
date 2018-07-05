//
//  MenuViewModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 06/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

protocol SecondScreenViewModelType {
    var numberOfRows: Int { get }
    var firstScreenItemName: String { get }
    func headerImage() -> UIImage
//    var menuItems: [MenuItem] { get }
    func selectedIndexPath(forIndexPath indexPath: IndexPath)
    func getCellViewModel(forIndexPath indexPath: IndexPath) -> SecondScreenCellViewModelType?
    func getThirdScreenViewModelForSelectedRow() -> ThirdScreenViewModelType?
}
