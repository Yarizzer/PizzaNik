//
//  SearchTableViewCell.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 27/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemGroup: UILabel!
    
    weak var searchCellViewModel: SearchCellModelType? {
        willSet(cellModel) {
            guard let cellModel = cellModel else { return }
            
            itemName.text = cellModel.itemName
            itemGroup.text = cellModel.itemGroup
            itemImage.image = cellModel.itemImage
        }
    }
    
    fileprivate func setCellBorder() {
        
        let bordersColor = #colorLiteral(red: 1, green: 0.6039215686, blue: 0, alpha: 1)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = bordersColor.cgColor
        self.layer.borderWidth = 1
    }
    
    fileprivate func setImageBorder() {
        let bordersColor = #colorLiteral(red: 1, green: 0.6039215686, blue: 0, alpha: 1)
        
        itemImage.layer.cornerRadius = itemImage.frame.height /  2
        itemImage.layer.masksToBounds = true
        itemImage.layer.borderColor = bordersColor.cgColor
        itemImage.layer.borderWidth = 2
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCellBorder()
        setImageBorder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
