//
//  AddToCartButton.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 21/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class AddToCartButton: UIButton {

    fileprivate func setBorder() {
        let bordersColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = bordersColor.cgColor
        self.layer.borderWidth = 3
        self.layer.backgroundColor = backgroundColor.cgColor
    }
    
    fileprivate var buttonShapeLayer: CAShapeLayer! {
        didSet{
            buttonShapeLayer.borderWidth = 3
            let fillColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            buttonShapeLayer.fillColor = fillColor.cgColor
            let baseLineColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            buttonShapeLayer.borderColor = baseLineColor.cgColor
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        setBorder()
        self.showsTouchWhenHighlighted = true
        let height = self.bounds.size.height
        self.bounds.size.height = 0
        
        UIView.animate(withDuration: 2, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.allowUserInteraction], animations: {
            self.bounds.size.height += height
        })
    }

}
