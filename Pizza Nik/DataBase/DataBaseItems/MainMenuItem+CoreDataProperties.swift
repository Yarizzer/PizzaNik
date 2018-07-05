//
//  MainMenuItem+CoreDataProperties.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 21/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
//

import Foundation
import CoreData


extension MainMenuItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainMenuItem> {
        return NSFetchRequest<MainMenuItem>(entityName: "MainMenuItem")
    }

    @NSManaged public var discription: String?
    @NSManaged public var image: NSData?
    @NSManaged public var name: String?
    @NSManaged public var priority: Int16
    @NSManaged public var menuItem: NSSet?

}

// MARK: Generated accessors for menuItem
extension MainMenuItem {

    @objc(addMenuItemObject:)
    @NSManaged public func addToMenuItem(_ value: MenuItem)

    @objc(removeMenuItemObject:)
    @NSManaged public func removeFromMenuItem(_ value: MenuItem)

    @objc(addMenuItem:)
    @NSManaged public func addToMenuItem(_ values: NSSet)

    @objc(removeMenuItem:)
    @NSManaged public func removeFromMenuItem(_ values: NSSet)

}
