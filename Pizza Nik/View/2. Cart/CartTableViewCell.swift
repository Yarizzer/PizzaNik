//
//  CartTableViewCell.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 30/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    var cellModel: CartCellViewModelType? {
        didSet{
            guard let model = cellModel else { return }
            self.itemNameLabel.text = model.itemName
            self.itemImageView.image = model.itemImage()
            self.itemQuantityLabel.text = String(describing: model.quantity)
            self.groupNameLabel.text = model.itemGroup
            self.summaryLabel.text = model.updateSummary(withValue: model.quantity)
            
        }
    }
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    @IBOutlet weak var decreaseBtn: IncreaseDecreaseButton!
    
    @IBAction func decreaseBtnTapped(_ sender: UIButton) {
        guard let quantity = Int(itemQuantityLabel.text!) else { return }
        let itemQuantity = quantity - 1
        itemQuantityLabel.text = String(describing: itemQuantity)
        if quantity == 0 { sender.isEnabled = false }
        self.summaryLabel.text = cellModel?.updateSummary(withValue: itemQuantity)

    }
    
    @IBAction func increaseBtnTapped(_ sender: UIButton) {
        guard let quantity = Int(itemQuantityLabel.text!) else { return }
        let itemQuantity = quantity + 1
        itemQuantityLabel.text = String(describing: itemQuantity)
        self.summaryLabel.text = cellModel?.updateSummary(withValue: itemQuantity)
        decreaseBtn.isEnabled = true
        
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
        
        itemImageView.layer.cornerRadius = itemImageView.frame.height /  2
        itemImageView.layer.masksToBounds = true
        itemImageView.layer.borderColor = bordersColor.cgColor
        itemImageView.layer.borderWidth = 1
    }
    
    fileprivate func setSlideMarker() {
        slideMarker = CAShapeLayer()
        self.layer.addSublayer(slideMarker)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCellBorder()
        setImageBorder()
//        setSlideMarker()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
