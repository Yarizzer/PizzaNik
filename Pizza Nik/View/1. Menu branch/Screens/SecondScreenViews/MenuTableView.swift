//
//  MenuTableView.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 26/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class MenuTableView: UITableView {

    var heightConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let header = tableHeaderView else {return}
        if let imageView = header.subviews.first as? UIImageView {
            heightConstraint = imageView.constraints.filter{$0.identifier == "mainManuHeightConstraint"}.first
            bottomConstraint = header.constraints.filter{$0.identifier == "mainManuBottomConstraint"}.first
        }
        
        let offsetY = -contentOffset.y
        bottomConstraint?.constant = offsetY >= 0 ? 0 : offsetY/3
        heightConstraint?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        
        header.clipsToBounds = offsetY <= 0
        
    }

}
