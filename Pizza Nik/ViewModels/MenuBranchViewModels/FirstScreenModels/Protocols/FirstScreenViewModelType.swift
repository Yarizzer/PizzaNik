//
//  MainMenuModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 06/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol FirstScreenViewModelType {
    var numberOfRows: Int { get }
    func getCellViewModel(forIndexPath indexPath: IndexPath) -> FirstScreenCellViewModelType?
    func getCellViewModel(forIndex index: Int) -> FirstScreenCellViewModelType?
    func selectedIndexPath(forIndexPath indexPath: IndexPath)
    func getSecondScreenViewModelForSelectedRow() -> SecondScreenViewModelType?
    
}
