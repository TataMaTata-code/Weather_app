//
//  WeekCollectionViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit
import Lottie

class WeekCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "WeekCollectionViewCell"
    
    let dayOfWeek: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    let iconWeather: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    let temperature: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 25,weight: .medium)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    func configText() {
        contentView.addSubview(dayOfWeek)
        contentView.addSubview(iconWeather)
        contentView.addSubview(temperature)
        
        dayOfWeek.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(iconWeather.snp.top).offset(-10)
        }
        
        iconWeather.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(49)
        }
        
        temperature.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconWeather.snp.bottom).offset(10)
        }
    }
}

