//
//  CurrentWeatherTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 19/11/21.
//
import UIKit

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
        text.font = UIFont.systemFont(ofSize: 43, weight: .medium)
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
        text.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    var humidityLabel: UILabel = {
       let text = UILabel()
//        text.text = "Humidity: 86%"
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    var windLabel: UILabel = {
       let text = UILabel()
//        text.text = "Wind: 6 m/s"
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        text.textAlignment = .center
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
//            make.height.equalTo(270)
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        containerView.backgroundColor = .clear
    }
    
    private func configCityLabel() {
        
        containerView.addSubview(cityName)
        cityName.snp.makeConstraints { make in
//            make.height.equalTo(60)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
    }
    
    private func configTemperatureLabel() {
        
        containerView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
//            make.height.equalTo(60)
            make.top.equalTo(cityName.snp.bottom).offset(10)
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
        humidityLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(descriptionWeather.snp.bottom).offset(10)
        }
    }
    
    private func configWind() {
        containerView.addSubview(windLabel)
        windLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(humidityLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(40)
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
