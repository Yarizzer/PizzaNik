//
//  MenuItem+CoreDataProperties.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 24/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
//

import Foundation
import CoreData


extension MenuItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuItem> {
        return NSFetchRequest<MenuItem>(entityName: "MenuItem")
    }

    @NSManaged public var ingredients: NSObject?
    @NSManaged public var itemDiscription: String?
    @NSManaged public var itemImage: NSData?
    @NSManaged public var itemName: String?
    @NSManaged public var itemPrice: Int16
    @NSManaged public var itemPriority: Int16
    @NSManaged public var searchTags: String?
    @NSManaged public var cart: Cart?
    @NSManaged public var mainMenuItems: MainMenuItem?

}
