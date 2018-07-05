//
//  MainMenuViewModel.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 06/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class FirstScreenViewModel {
    private var selectedIndexPath: IndexPath?
    private var items: [MainMenuItem] {
        return MainDataBaseManager.shared.mainMenuItems
    }
}

extension FirstScreenViewModel: FirstScreenViewModelType {
    func selectedIndexPath(forIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    //creates a model for selected parent directory
    func getSecondScreenViewModelForSelectedRow() -> SecondScreenViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return SecondScreenViewModel(forItem: items[selectedIndexPath.row])
    }
    
    var numberOfRows: Int {
        return items.count
    }
    
    //creaates a models to cells params
    func getCellViewModel(forIndexPath indexPath: IndexPath) -> FirstScreenCellViewModelType? {
        let item = items[indexPath.row]
        return FirstScreenCellViewModel(forItem: item)
    }
    
    func getCellViewModel(forIndex index: Int) -> FirstScreenCellViewModelType? {
        let item = items[index]
        return FirstScreenCellViewModel(forItem: item)
    }

    
    
}
