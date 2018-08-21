//
//  Forecast.swift
//  Shiny Rainy Cloudy
//
//  Created by Eliza Vel Rosario on 21/08/2018.
//  Copyright © 2018 Eliza Velcom.eliza. All rights reserved.
//

import Foundation
import Alamofire

class TodayForecast {
    
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
        
        print(CURRENT_WEATHER_URL)
        Alamofire.request(.GET,CURRENT_WEATHER_URL).responseJSON { response in
            //print(response.2.value)
            let apireturn = response.2.value
            
            if let dict = apireturn as? Dictionary<String,AnyObject>{
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main
                        //print(self._weatherType)
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject>{
                    
                    if let temp = main["temp"] as? Double {
                        
                        let kelvinToFarenheitPreDivision = (temp * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        
                        
                        self._currentTemp = kelvinToFarenheit
                        //print(self._currentTemp)
                    }
                }
                
                if let name = dict["name"] as? String{
                    self._cityName = name
                    //print(self._cityName)
                }
                
                               
            }
         complete()
            
        }
    }
    
    
    
    
    
}