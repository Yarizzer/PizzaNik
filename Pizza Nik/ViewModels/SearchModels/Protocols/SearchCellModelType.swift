//
//  SearchCellModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 27/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

protocol SearchCellModelType: class {
    var itemName: String { get }
    var itemImage: UIImage { get }
    var itemGroup: String { get }
}
