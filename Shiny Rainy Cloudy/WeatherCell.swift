//
//  WeatherCell.swift
//  Shiny Rainy Cloudy
//
//  Created by Eliza Vel Rosario on 21/08/2018.
//  Copyright © 2018 Eliza Velcom.eliza. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherTypeImage: UIImageView!
    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherHighTemp: UILabel!
    @IBOutlet weak var weatherLowTemp: UILabel!
    
    func configureCell(forecast: WeeklyForecast){
        
        weatherTypeImage.image = UIImage(named: forecast.weatherType)
        weatherDate.text = forecast.date
        weatherType.text = forecast.weatherType
        weatherHighTemp.text = "\(forecast.highTemp)"
        weatherLowTemp.text = "\(forecast.lowTemp)"
    }
    
}
