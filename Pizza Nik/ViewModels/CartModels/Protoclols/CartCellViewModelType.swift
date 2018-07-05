//
//  CartCellViewModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 14/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

protocol CartCellViewModelType: class {
    var itemName: String { get }
    var itemGroup: String { get }
    var quantity: Int { get }
    
    
    func itemImage() -> UIImage
    func updateSummary(withValue value: Int) -> String
}
