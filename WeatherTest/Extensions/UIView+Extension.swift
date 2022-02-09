//
//  UIView+Extension.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit

extension UIView {
    
    func addCornerRadius(contentView: UIView, cornerRadius: CGFloat) {
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
    }
    
    func addShadows(color: UIColor, opacity: Float, radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = radius
        layer.rasterizationScale = UIScreen.main.brightness
    }
    
    func addGradientAxial(firstColor: UIColor, secondColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.frame = bounds
        gradient.colors = [firstColor.cgColor,
                           secondColor.cgColor]
        gradient.locations = [ 0, 1]
        layer.insertSublayer(gradient, at: 0)
    }
    
    func blurView(style: UIBlurEffect.Style) {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: style)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
    }
}
