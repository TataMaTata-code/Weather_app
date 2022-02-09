//
//  CurrentWeatherTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//
import UIKit
import SnapKit

class CurrentWeatherTableViewCell: UITableViewCell {

    static let identifier = "CurrentWeatherTableViewCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 25
        return view
    }()
    
    var cityName: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        text.textAlignment = .center
        text.textColor = .white
        text.numberOfLines = 0
        return text
    }()
    
    var temperatureLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 120, weight: .thin)
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    var descriptionWeather: UILabel = {
       let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    var humidityIcon: UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(systemName: "humidity.fill")
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    var humidityLabel: UILabel = {
       let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    var windIcon: UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(systemName: "wind")
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    var windLabel: UILabel = {
       let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        text.textColor = .white
        return text
    }()
    
    var sunriseIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "sunrise.fill")?.withRenderingMode(.alwaysOriginal)
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    var sunriseLabel: UILabel = {
       let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        text.textColor = .white
        return text
    }()
    
    var sunsetIcon: UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(systemName: "sunset.fill")?.withRenderingMode(.alwaysOriginal)
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    var sunsetLabel: UILabel = {
       let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        text.textColor = .white
        return text
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }

    private func config() {
        configСontainerView()
        configCityLabel()
        configTemperatureLabel()
        configWeatherMain()
        configHumidity()
        configWind()
        configSunrise()
        configSunset()
    }
    private func configСontainerView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        containerView.backgroundColor = .clear
    }
    
    private func configCityLabel() {
        containerView.addSubview(cityName)
        cityName.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
    }
    
    private func configTemperatureLabel() {
        containerView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func configWeatherMain() {
        containerView.addSubview(descriptionWeather)
        descriptionWeather.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom)
        }
    }
    
    private func configHumidity() {
        containerView.addSubview(humidityLabel)
        containerView.addSubview(humidityIcon)
        
        humidityLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.center.x / 2)
            make.top.equalTo(descriptionWeather.snp.bottom).offset(25)
        }
        
        humidityIcon.snp.makeConstraints { make in
            make.right.equalTo(humidityLabel.snp.left)
            make.bottom.equalTo(humidityLabel.snp.bottom)
            make.height.equalTo(humidityLabel.snp.height)
            make.width.equalTo(humidityIcon.snp.height)
        }
    }
    
    private func configWind() {
        containerView.addSubview(windLabel)
        containerView.addSubview(windIcon)
        
        windLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.center.x / 2)
            make.top.equalTo(humidityLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().inset(15)
        }
        windIcon.snp.makeConstraints { make in
            make.right.equalTo(windLabel.snp.left)
            make.bottom.equalTo(windLabel.snp.bottom)
            make.height.equalTo(windLabel.snp.height)
            make.width.equalTo(windIcon.snp.height)
        }
    }
    
    private func configSunrise() {
        containerView.addSubview(sunriseIcon)
        containerView.addSubview(sunriseLabel)
        
        sunriseLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.center.x * 1.5)
            make.top.equalTo(descriptionWeather.snp.bottom).offset(25)
        }
        sunriseIcon.snp.makeConstraints { make in
            make.right.equalTo(sunriseLabel.snp.left)
            make.bottom.equalTo(sunriseLabel.snp.bottom)
            make.height.equalTo(sunriseLabel.snp.height)
            make.width.equalTo(sunriseIcon.snp.height)
        }
    }
    
    private func configSunset() {
        containerView.addSubview(sunsetIcon)
        containerView.addSubview(sunsetLabel)
        
        sunsetLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.center.x * 1.5)
            make.top.equalTo(sunriseLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().inset(15)
        }
        sunsetIcon.snp.makeConstraints { make in
            make.right.equalTo(sunsetLabel.snp.left)
            make.bottom.equalTo(sunsetLabel.snp.bottom)
            make.height.equalTo(sunsetLabel.snp.height)
            make.width.equalTo(sunriseIcon.snp.height)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentWeatherTableViewCell", bundle: nil)
    }
}
