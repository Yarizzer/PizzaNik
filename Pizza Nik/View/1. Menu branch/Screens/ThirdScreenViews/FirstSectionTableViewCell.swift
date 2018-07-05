//
//  DetailOverviewTableViewCell.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 24/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class FirstSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var detailLabel: UILabel!
    
    weak var thirdScreenFirstSectionCellViewModel: ThirdScreenFirstSectionCellType? {
        willSet(cellModel) {
            guard let cellModel = cellModel else { return }
            
            detailLabel.text = cellModel.discription
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bordersColor = #colorLiteral(red: 1, green: 0.6039215686, blue: 0, alpha: 1)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = bordersColor.cgColor
        self.layer.borderWidth = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
