//
//  WeekCollectionViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit


class WeekCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "WeekCollectionViewCell"
    
    var blurEffectView = UIVisualEffectView()
    
    let hours: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    let iconWeather: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    let temperature: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 18,weight: .medium)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        return textLabel
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        blurEffectView.removeFromSuperview()
        hours.removeFromSuperview()
        iconWeather.removeFromSuperview()
        temperature.removeFromSuperview()
    }
    
    func configCell() {
        configText()
        addBlurEffect()
    }
    
    private func configText() {
        contentView.addSubview(hours)
        contentView.addSubview(iconWeather)
        contentView.addSubview(temperature)
        
        hours.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(iconWeather.snp.top).offset(-10)
        }
        
        iconWeather.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(25)
            make.height.equalTo(20)
        }
        
        temperature.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconWeather.snp.bottom).offset(10)
        }
    }
    private func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.3
        contentView.addSubview(blurEffectView)
        contentView.sendSubviewToBack(blurEffectView)
    }
}

