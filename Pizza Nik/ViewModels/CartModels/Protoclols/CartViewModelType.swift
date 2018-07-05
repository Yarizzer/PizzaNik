//
//  CartViewProtocol.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 14/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol CartViewModelType {
    var numberOfRows: Int { get }
    
    func removeItem(forIndexPath indexPath: IndexPath)
    func setSelectedIndexPath(forIndexPath indexPath: IndexPath)
    func getCartCellViewModel(forIndexPath indexPath: IndexPath) -> CartCellViewModelType?
    func updateCartItemsArray(for item: MenuItem, with value: Int)
}
