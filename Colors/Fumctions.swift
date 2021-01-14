//
//  Fumctions.swift
//  Colors
//
//  Created by yulin on 2021/1/13.
//

import Foundation
import UIKit

func setBoarderColor(shape:UIButton){
    
    let borderGradient = CAGradientLayer()
    borderGradient.frame = CGRect(origin: CGPoint.zero, size: shape.frame.size)
    borderGradient.colors = [UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1).cgColor,UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.2).cgColor,UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0   ).cgColor]
    borderGradient.locations = [0, 0.5, 1]
    
    
    borderGradient.startPoint = CGPoint (x: 0, y: 0)
    borderGradient.endPoint = CGPoint(x: 1, y: 1 )
    borderGradient.cornerRadius = 10
    
    let borderShape = CAShapeLayer()
    borderShape.lineWidth = 3
    borderShape.path = UIBezierPath(roundedRect: shape.bounds, cornerRadius: 10).cgPath
    borderShape.strokeColor = UIColor.black.cgColor
    borderShape.fillColor = UIColor.clear.cgColor
    borderGradient.mask = borderShape
    shape.layer.addSublayer(borderGradient)
}

