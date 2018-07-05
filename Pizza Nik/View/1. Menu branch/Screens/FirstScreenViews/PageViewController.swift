//
//  PageViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 16/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var viewModel: FirstScreenViewModelType?
    override func viewDidLoad() {
        super.viewDidLoad()

        MainDataBaseManager.shared.runManagers()
        viewModel = FirstScreenViewModel()
        
        dataSource = self
        
        if let firstVC = displayContentViewController(atIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func displayContentViewController(atIndex index: Int) -> ContentViewController? {
        guard let model = viewModel else { return nil }
        guard index >= 0 else { return nil }
        guard index < model.numberOfRows else { return nil }
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentViewController else { return nil }

        guard let itemModel = model.getCellViewModel(forIndex: index) else { return nil }
        vc.itemModel = itemModel
        vc.index = itemModel.itemOrder
        vc.itemsCount = model.numberOfRows
        return vc

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let vc = viewController as? ContentViewController else { return nil }
        guard let model = viewModel else { return nil }
        let viewControllerIndex = vc.index
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard model.numberOfRows > previousIndex else {
            return nil
        }
        
        return displayContentViewController(atIndex: previousIndex)

    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? ContentViewController else { return nil }
        guard let model = viewModel else { return nil }
        
        let viewControllerIndex = vc.index
        
        let nextIndex = viewControllerIndex + 1
        let itemsCount = model.numberOfRows
        
        guard itemsCount != nextIndex else { return nil }
        
        guard itemsCount > nextIndex else { return nil }
        
        
        return displayContentViewController(atIndex: nextIndex)

    }
}
