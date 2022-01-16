//
//  CurrentWeatherDescriptionTableViewCell.swift
//  WeatherTest
//
//  Created by Tata on 16/01/22.
//

import UIKit

class CurrentWeatherDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var humidityImage: UIImageView!
    @IBOutlet weak var windImage: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
