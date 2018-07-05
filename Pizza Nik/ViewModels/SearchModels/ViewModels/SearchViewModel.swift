//
//  SearchViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 27/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class SearchViewModel {
    private var items = MainDataBaseManager.shared.getMenuItems(forParentPriority: nil)
    private var filteredItems = [MenuItem]()
    private var selectedIndexPath: IndexPath?
    
}

extension SearchViewModel: SearchViewType {
    
    var numberOfRows: Int {
        return items.count
    }
    
    var numberOfFilteredRows: Int {
        return filteredItems.count
    }
    
    func getCellViewModel(forIndexPath indexPath: IndexPath) -> SearchCellModelType? {
        return SearchCellViewModel(forItem: items[indexPath.row])
    }
    
    func getFilteredCellViewModel(forIndexPath indexPath: IndexPath) -> SearchCellModelType? {
        return SearchCellViewModel(forItem: filteredItems[indexPath.row])
    }
    
    func updateFilteredItems(withText searchText: String, scope: String) {
        filteredItems = items.filter({(item : MenuItem) -> Bool in
            
            let doesCategoryMatch = (scope == "All") || (item.mainMenuItems?.name == scope)
            guard let searchTags = item.searchTags else { return false }
            return doesCategoryMatch && searchTags.lowercased().contains(searchText.lowercased())
        })
    }
    
    func getArrayOfGroupNames() -> [String] {
        let arrayOfItems = MainDataBaseManager.shared.mainMenuItems
        var array = [String]()
        array.append("All")
        for i in arrayOfItems {
            array.append(i.name ?? "")
        }
        return array
    }
    
    func selectedIndexPath(forIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        
    }
    
    func getDetailScreenViewModelForSelectedRow() -> ThirdScreenViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        if filteredItems.isEmpty {
            return ThirdScreenViewModel(forItem: items[selectedIndexPath.row])
        } else {
            return ThirdScreenViewModel(forItem: filteredItems[selectedIndexPath.row])
        }
    }
}
