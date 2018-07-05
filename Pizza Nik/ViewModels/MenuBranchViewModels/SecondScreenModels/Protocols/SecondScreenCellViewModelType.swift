//
//  MenuCellViewModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 09/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

protocol SecondScreenCellViewModelType: class {
    var itemName: String { get }
    var itemDiscription: String { get }
    
    func itemPrice() -> String
    func itemImage() -> UIImage?
    func getTextForDiscussAcition() -> String
    func addToCart()
}
