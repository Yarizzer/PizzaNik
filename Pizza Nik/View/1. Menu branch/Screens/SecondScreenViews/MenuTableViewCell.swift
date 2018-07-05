//
//  MenuTableViewCell.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 21/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var menuItemImage: UIImageView!
    @IBOutlet weak var menuItemNameLabel: UILabel!
    @IBOutlet weak var menuItemDiscriptionLebel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var secondScreenCellViewModel: SecondScreenCellViewModelType? {
        willSet(cellModel) {
            guard let cellModel = cellModel else { return }
            
            menuItemNameLabel.text = cellModel.itemName
            menuItemDiscriptionLebel.text = cellModel.itemDiscription
            
            menuItemImage.image = cellModel.itemImage()
            priceLabel.text = cellModel.itemPrice()
        }
    }
    
    var slideMarker: CAShapeLayer! {
        didSet{
            slideMarker.lineWidth = 1
            let markerColor = #colorLiteral(red: 0.9882352941, green: 0.7764705882, blue: 0.03921568627, alpha: 1)
            slideMarker.fillColor = markerColor.cgColor
            slideMarker.strokeEnd = 1
            slideMarker.strokeColor = markerColor.cgColor
            
            let path = UIBezierPath()
            //Errow type path
            let startPathPoint = CGPoint(x: self.frame.size.width - self.frame.size.width / 16, y: self.frame.size.height / 2)
            let firstPoint = CGPoint(x: self.frame.size.width - self.frame.size.width / 36, y: self.frame.size.height)
            let secondPoint = CGPoint(x: self.frame.size.width, y: self.frame.size.height)
            let thirdPoint = CGPoint(x: self.frame.size.width, y: 0)
            let fourthPoint = CGPoint(x: self.frame.size.width - self.frame.size.width / 36, y: 0)
            let fifthPoint = startPathPoint
            path.move(to: startPathPoint)
            path.addLine(to: firstPoint)
            path.addLine(to: secondPoint)
            path.addLine(to: thirdPoint)
            path.addLine(to: fourthPoint)
            path.addLine(to: fifthPoint)
            //trapezoid type path
            //            let startPathPoint = CGPoint(x: self.frame.size.width - self.frame.size.width / 12, y: self.frame.size.height)
            //            let firstPoint = CGPoint(x: self.frame.size.width - self.frame.size.width / 36, y: 0)
            //            let secondPoint = CGPoint(x: self.frame.size.width, y: 0)
            //            let thirdPoint = CGPoint(x: self.frame.size.width, y: self.frame.size.height)
            //            let fourthPoint = startPathPoint
            //            path.move(to: startPathPoint)
            //            path.addLine(to: firstPoint)
            //            path.addLine(to: secondPoint)
            //            path.addLine(to: thirdPoint)
            //            path.addLine(to: fourthPoint)
            slideMarker.path = path.cgPath
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
        
        menuItemImage.layer.cornerRadius = menuItemImage.frame.height /  2
        menuItemImage.layer.masksToBounds = true
        menuItemImage.layer.borderColor = bordersColor.cgColor
        menuItemImage.layer.borderWidth = 2
    }
    
    fileprivate func setSlideMarker() {
        slideMarker = CAShapeLayer()
        self.layer.addSublayer(slideMarker)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.menuItemNameLabel.center.x -= self.bounds.size.width
        })
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.menuItemDiscriptionLebel.center.x -= self.bounds.size.width
        })
        
        
        let degreeForNameLabel: Double = 45
        let rotationAngleForNameLabel = CGFloat(degreeForNameLabel * Double.pi / 180)
        let rotationTransformForNameLabel = CATransform3DMakeRotation(rotationAngleForNameLabel, 1, 0, 0)
        self.menuItemNameLabel.layer.transform = rotationTransformForNameLabel
        
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseInOut, animations: {
            self.menuItemNameLabel.layer.transform = CATransform3DIdentity
        })
        
        let degreeForPriceLabel: Double = 90
        let rotationAngleForPriceLabel = CGFloat(degreeForPriceLabel * Double.pi / 180)
        let rotationTransformForPriceLabel = CATransform3DMakeRotation(rotationAngleForPriceLabel, 1, 0, 0)
        self.priceLabel.layer.transform = rotationTransformForPriceLabel
        
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseInOut, animations: {
            self.priceLabel.layer.transform = CATransform3DIdentity
        })
        
        setCellBorder()
        setImageBorder()
        setSlideMarker()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
