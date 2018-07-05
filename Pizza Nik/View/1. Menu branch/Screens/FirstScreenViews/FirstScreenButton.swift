//
//  ShowGoodsButton.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 16/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class FirstScreenButton: UIButton {

    private var buttonColor: UIColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
    
    var path: UIBezierPath?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.showsTouchWhenHighlighted = true
        let radius = self.frame.size.width / 2
        path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        buttonColor.setFill()
        path?.fill()
        
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.3842773438, blue: 1, alpha: 1)
        self.layer.borderWidth = 1
        self.alpha = 0.75
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let path = path {
            return path.contains(point)
        } else {
            return false
        }
    }
 

}
