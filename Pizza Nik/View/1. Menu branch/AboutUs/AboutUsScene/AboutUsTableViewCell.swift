//
//  AboutUsTableViewCell.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 28/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {

    @IBOutlet weak var aboutUsLabel: UILabel!
    
    var cellModel: AddInfoCellViewType? {
        willSet(cellModel){
            guard let model = cellModel else { return }

            aboutUsLabel.text = model.categoryName
        }
    }
    
    fileprivate func setCellBorder() {
        
        let bordersColor = #colorLiteral(red: 1, green: 0.6039215686, blue: 0, alpha: 1)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = bordersColor.cgColor
        self.layer.borderWidth = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
