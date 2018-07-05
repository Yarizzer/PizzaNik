//
//  MenuManager.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 04/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MenuManager {
    
    static let shared = MenuManager()

    //deleting main menu items and menu items
    fileprivate func deleteAllrecordsFromDataBase() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let mainMenuFetchRequest: NSFetchRequest<MainMenuItem> = MainMenuItem.fetchRequest()
        
        do {
            for item in try context.fetch(mainMenuFetchRequest) {
                context.delete(item)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//        }
        
        let menuItemsFetchRequest: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        
        do {
            for item in try context.fetch(menuItemsFetchRequest) {
                context.delete(item)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//        }
        
    }

    //filling database with plist file's data
    fileprivate func fillDataBaseFromFiles() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let arrayOfMainElementsFromFile = getArrayOfRecordFromMainMenuFile()
        for element in arrayOfMainElementsFromFile {
            let entity = NSEntityDescription.entity(forEntityName: "MainMenuItem", in: context)
            let mainMenuObject = NSManagedObject(entity: entity!, insertInto: context) as! MainMenuItem
            mainMenuObject.name = element.value(forKey: "name") as? String
            let imageName = element["image"] as? String
            let imageData = UIImageJPEGRepresentation(UIImage(named: imageName!)!, 1)
            mainMenuObject.image = imageData as NSData?
            mainMenuObject.discription = element.value(forKey: "discription") as? String
            mainMenuObject.priority = element.value(forKey: "priority") as! Int16
        }
        do {
            try
                context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        let arrayOfMainElementsInDataBase = getMainMenuItemsFromDataBase(withPriority: nil)
        
        let arrayOfRecordsInFile = getArrayOfRecordFromMenuFile()
        for element in arrayOfRecordsInFile {
            let entity = NSEntityDescription.entity(forEntityName: "MenuItem", in: context)
            let menuObject = NSManagedObject(entity: entity!, insertInto: context) as! MenuItem
            menuObject.itemName = element.value(forKey: "itemName") as? String
            let imageName = element["itemImageName"] as? String
            let imageData = UIImageJPEGRepresentation(UIImage(named: imageName!)!, 1)
            menuObject.itemImage = imageData as NSData?
            menuObject.itemDiscription = element.value(forKey: "itemDiscription") as? String
            menuObject.searchTags = element.value(forKey: "searchTags") as? String
            menuObject.itemPriority = element.value(forKey: "itemPriority") as! Int16
            menuObject.itemPrice = element.value(forKey: "itemPrice") as! Int16
            
            let parentId = element.value(forKey: "parentId") as! Int
            
            menuObject.mainMenuItems = arrayOfMainElementsInDataBase[parentId]
            
            menuObject.ingredients = element.value(forKey: "ingredients") as? NSObject
        }
        do {
            try
                context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //gets an array of records from Data.plist file
    fileprivate func getArrayOfRecordFromMainMenuFile() -> [NSDictionary] {
        var arrayofRecords = [NSDictionary]()
        let pathToFile = Bundle.main.path(forResource: "Data", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: pathToFile!)!
        for dictionary in dataArray {
            let dictItem = dictionary as! NSDictionary
            let entity = ["name": dictItem.value(forKey: "name") as! String,
                          "image": dictItem.value(forKey: "imageName") as! String,
                          "discription": dictItem.value(forKey: "discription") as! String,
                          "priority": dictItem.value(forKey: "priority") as! Int] as [String : Any]
            arrayofRecords.append(entity as NSDictionary)
        }
        
        return arrayofRecords
    }

    //gets an array of records from MenuItemsData.plist file
    fileprivate func getArrayOfRecordFromMenuFile() -> [NSDictionary]{

        var arrayofRecords = [NSDictionary]()
        let pathToFile = Bundle.main.path(forResource: "MenuItemsData", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: pathToFile!)!
        for dictionary in dataArray {
            let dictItem = dictionary as! NSDictionary
            let dictIngredients = dictItem.value(forKey: "ingredients") as! NSArray
            var itemIngredients = [Any]()
            for i in dictIngredients {
                itemIngredients.append(i as! String)
            }

            let entity = ["itemName": dictItem.value(forKey: "name") as! String,
                          "itemImageName": dictItem.value(forKey: "imageName") as! String,
                          "itemDiscription": dictItem.value(forKey: "disription") as! String,
                          "searchTags": dictItem.value(forKey: "searchTags") as! String,
                          "itemPriority": dictItem.value(forKey: "priority") as! Int,
                          "itemPrice": dictItem.value(forKey: "price") as! Int,
                          "parentId": dictItem.value(forKey: "parentId") as! Int,
                          "ingredients": itemIngredients] as [String : Any]
            arrayofRecords.append(entity as NSDictionary)
        }
        
        return arrayofRecords
    }

    //gets an array of MenuItems from dataBase
    func getMenuItemsFromDataBase(forParentPriority parentOrder: Int16?) -> [MenuItem] {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        
        let mainMenuItem = getMainMenuItemsFromDataBase(withPriority: parentOrder)
        print("fetched count \(mainMenuItem.count)")
        if parentOrder != nil, mainMenuItem.count > 0 {
            fetchRequest.predicate = NSPredicate(format: "mainMenuItems == %@", mainMenuItem[0])
        }

        var arrayToReturn = [MenuItem]()
        do {
            let arrayOfFetchedElements = try context.fetch(fetchRequest)
            
            guard !arrayOfFetchedElements.isEmpty else { return arrayToReturn }
            arrayToReturn = arrayOfFetchedElements
  
        } catch {
            print(error.localizedDescription)
        }
        return arrayToReturn.sorted{$0.itemPriority < $1.itemPriority }
    }

    //gets an array of MainMenuItems from dataBase
    func getMainMenuItemsFromDataBase(withPriority priortiy: Int16?) -> [MainMenuItem] {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MainMenuItem> = MainMenuItem.fetchRequest()
        
        if let itemPriority = priortiy {
            fetchRequest.predicate = NSPredicate(format: "priority == \(itemPriority)")
        }
        
        var arrayToReturn = [MainMenuItem]()
        do {
            let arrayOfElementsInDataBase = try context.fetch(fetchRequest)
            guard !arrayOfElementsInDataBase.isEmpty else { return arrayToReturn }
            arrayToReturn = arrayOfElementsInDataBase.sorted {$0.priority < $1.priority}
        } catch {
            print(error.localizedDescription)
        }
        return arrayToReturn
    }

    private init() {}
}

extension MenuManager: DataBaseManageble {
    func removeAllItems() {
        deleteAllrecordsFromDataBase()
    }
    
    func run() {
        print("Menu manager starts...")
//        removeAllItems()
//        fillDataBaseFromFiles()
// 
    }
}
