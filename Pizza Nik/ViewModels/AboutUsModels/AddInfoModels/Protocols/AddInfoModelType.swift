//
//  AddInfoModelType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 10/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol AddInfoModelType {
    var numberOfRows: Int { get }
    var getContentText: String { get }
    func getInfoCellModel(forIndexPath indexPath: IndexPath) -> AddInfoCellViewType?
    func setSelectedIndexPath(forIndexPath indexPath: IndexPath)
    func getScreenForDetailInfoForSelectedRow() -> DetailInfoViewType?
}
