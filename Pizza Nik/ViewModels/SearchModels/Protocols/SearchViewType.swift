//
//  SearchViewType.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 27/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol SearchViewType {
    var numberOfRows: Int { get }
    var numberOfFilteredRows: Int { get }
    func getCellViewModel(forIndexPath indexPath: IndexPath) -> SearchCellModelType?
    func getFilteredCellViewModel(forIndexPath indexPath: IndexPath) -> SearchCellModelType?
    func updateFilteredItems(withText searchText: String, scope: String)
    func getArrayOfGroupNames() -> [String]     //uses for scopes in searchController
    func selectedIndexPath(forIndexPath indexPath: IndexPath)
    func getDetailScreenViewModelForSelectedRow() -> ThirdScreenViewModelType?
}
