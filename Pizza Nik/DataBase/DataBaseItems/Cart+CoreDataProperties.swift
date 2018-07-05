//
//  Cart+CoreDataProperties.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 29/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var quantity: Int16
    @NSManaged public var order: Int16
    @NSManaged public var menuItem: MenuItem

}
