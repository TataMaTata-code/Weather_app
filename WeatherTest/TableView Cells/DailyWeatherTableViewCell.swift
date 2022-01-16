//
//  DailyWeatherTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    static let indetifier = "DailyWeatherTableViewCell"
    
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        configLabel()
    }
    
    private func configLabel() {
        minTempLabel.textColor = .white
        minTempLabel.alpha = 0.5
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DailyWeatherTableViewCell", bundle: nil)
    }
}
