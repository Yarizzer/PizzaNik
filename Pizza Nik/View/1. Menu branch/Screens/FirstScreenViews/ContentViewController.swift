//
//  ContentViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 16/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    var itemModel: FirstScreenCellViewModelType?
    var itemsCount = 0
    var index = 0
    
    @IBOutlet weak var menuGroupLabel: UILabel!
    @IBOutlet weak var menuImageButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBAction func imageBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "menuSegue", sender: nil)
    }
    //    var menuGroupName = ""
//    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let model = itemModel else { return }
        menuGroupLabel.text = model.itemName
        menuImageButton.setBackgroundImage(model.itemImage, for: .normal)
        
        self.pageControl.currentPage = index
        pageControl.numberOfPages = itemsCount
        
        

        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = itemModel else { return }
        if identifier == "menuSegue" {
            if let destinationVC = segue.destination as? MenuTableViewController {
                
                destinationVC.screenViewModel = viewModel.getSecondScreenViewModel()
            }
            
        }
        
        
        
    }


}
