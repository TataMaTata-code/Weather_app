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
        text.font = UIFont.systemFont(ofSize: 125)
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    var descriptionWeather: UILabel = {
       let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
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
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
        }
    }
    
    private func configHumidity() {
        containerView.addSubview(humidityLabel)
        containerView.addSubview(humidityIcon)
        
        humidityLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.center.x)
            make.top.equalTo(descriptionWeather.snp.bottom).offset(20)
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
            make.left.equalTo(contentView.center.x)
            make.right.equalToSuperview()
            make.top.equalTo(humidityLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        windIcon.snp.makeConstraints { make in
            make.right.equalTo(windLabel.snp.left)
            make.bottom.equalTo(windLabel.snp.bottom)
            make.height.equalTo(windLabel.snp.height)
            make.width.equalTo(windIcon.snp.height)
        }
    }
    
    func setupAllConfig(city: String, temperature: String, descrip: String, humidity: String, wind: String) {
        cityName.text = city
        temperatureLabel.text = temperature
        descriptionWeather.text = descrip
        humidityLabel.text = humidity
        windLabel.text = wind
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentWeatherTableViewCell", bundle: nil)
    }
}
