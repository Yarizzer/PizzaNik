//
//  MainMenuCellViewModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 06/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

protocol FirstScreenCellViewModelType: class {
    var itemName: String { get }
    var itemImage: UIImage { get }
    var itemOrder: Int { get }
    
    func getSecondScreenViewModel() -> SecondScreenViewModelType?
}
