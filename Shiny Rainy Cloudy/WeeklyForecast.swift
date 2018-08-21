//
//  Forecast.swift
//  Shiny Rainy Cloudy
//
//  Created by Eliza Vel Rosario on 21/08/2018.
//  Copyright © 2018 Eliza Velcom.eliza. All rights reserved.
//

import Foundation
import Alamofire

class WeeklyForecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    var date : String{
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp : Double {
        if _highTemp == nil {
            _highTemp = 0.00
        }
        return _highTemp
    }
    
    var lowTemp : Double {
        if _lowTemp == nil {
            _lowTemp = 0.00
        }
        return _lowTemp
    }
    
    
        
    init(weatherDict: Dictionary<String,AnyObject>){
        
        if let temp = weatherDict["temp"] as? Dictionary<String,AnyObject>{
            
            if let min = temp["min"] as? Double {
                let kelvinToFarenheitPreDivision = (min * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._lowTemp = kelvinToFarenheit
            }
            
            if let max = temp["max"] as? Double{
                let kelvinToFarenheitPreDivision = (max * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._highTemp = kelvinToFarenheit
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>] {
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = NSDate(timeIntervalSince1970: date)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .FullStyle
            dateFormatter.timeZone = .None
            dateFormatter.dateFormat = "EEEE"
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
        
        
        
    }
    
    
}

extension NSDate{
    func dayOfTheWeek() -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(self)
    }
}