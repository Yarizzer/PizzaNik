//
//  IncreaseDecreaseButton.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 25/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class IncreaseDecreaseButton: UIButton, CAAnimationDelegate {
    
    fileprivate func setButtonBorder() {
        
        let bordersColor = #colorLiteral(red: 1, green: 0.6039215686, blue: 0, alpha: 1)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = bordersColor.cgColor
        self.layer.borderWidth = 1
    }
    
    override func draw(_ rect: CGRect) {
        setButtonBorder()
        showsTouchWhenHighlighted = true
    }

}
