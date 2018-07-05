//
//  DetailTableViewCell.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 24/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class SecondSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    weak var thirdScreenSecondSectionCellViewModel: ThirdScreenSecondSectionCellType? {
        willSet(cellModel) {
            guard let cellModel = cellModel else { return }
            
            detailLabel.text = cellModel.ingredient
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
