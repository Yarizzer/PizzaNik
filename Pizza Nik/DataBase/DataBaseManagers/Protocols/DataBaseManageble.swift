//
//  DataBaseManageble.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 04/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol DataBaseManageble {
    // preparations when app starts
    func run()
    
    //needs for debug
    func removeAllItems()
    
}
