//
//  WeekCollectionViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "WeekCollectionViewCell"
    
    let dayOfWeek: UILabel = {
        let textLabel = UILabel()
        textLabel.text = ""
        textLabel.font = UIFont.systemFont(ofSize: 30)
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    let iconWeather: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "")
        return icon
    }()
    
    let temperature: UILabel = {
        let textLabel = UILabel()
        textLabel.text = ""
        textLabel.font = UIFont.systemFont(ofSize: 30)
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configText()
    }
    
    func configText() {
        contentView.addSubview(dayOfWeek)
        contentView.addSubview(iconWeather)
        contentView.addSubview(temperature)
        
        dayOfWeek.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        
        iconWeather.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
            make.top.equalTo(dayOfWeek.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        temperature.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconWeather.snp.bottom).offset(10)
        }
    }
}

