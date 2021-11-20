//
//  UIView+Extension.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit

extension UIView {
    
    func addCornerRadius(contentView: UIView, cornerRadius: CGFloat, borderWidth: CGFloat, color: UIColor) {
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.borderWidth = borderWidth
        contentView.layer.borderColor = color.cgColor
        contentView.layer.masksToBounds = true
    }
}
