//
//  Forecast.swift
//  Shiny Rainy Cloudy
//
//  Created by Eliza Vel Rosario on 21/08/2018.
//  Copyright © 2018 Eliza Velcom.eliza. All rights reserved.
//

import Foundation
import Alamofire

class TodayWeatherForecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    private var _cityName: String!
    
    var date : String{
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        
        let currentDate = dateFormatter.stringFromDate(NSDate())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp : Double {
        if _currentTemp == nil {
            _currentTemp = 0.00
        }
        return _currentTemp
    }
    
    var cityName : String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    
    func downloadWeatherToday (complete: downloadCompleted){
        
        let url = NSURL(fileURLWithPath: "\(BASE_URL)\(WEATHER_URL)\(LATITUDE)14\(LONGITUDE)194")
        print(url)
        Alamofire.request(.GET,url).responseJSON { response in
            print(response.2.value)
            
        }
    }
    
    
    
    
    
}