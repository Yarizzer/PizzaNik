//
//  AddInfoViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 10/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {

    var viewModel: DetailInfoViewType?
    @IBOutlet weak var contentText: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        contentText.text = viewModel.getDetailText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = viewModel else { return }
        self.navigationItem.title = model.getCategoryName()
        // Do any additional setup after loading the view.
    }
}
