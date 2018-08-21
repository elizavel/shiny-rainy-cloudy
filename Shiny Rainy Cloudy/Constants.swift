//
//  Constants.swift
//  Shiny Rainy Cloudy
//
//  Created by Eliza Vel Rosario on 21/08/2018.
//  Copyright © 2018 Eliza Velcom.eliza. All rights reserved.
//

import Foundation

var BASE_URL = "http://samples.openweathermap.org/data/2.5/"
var WEATHER_URL = "weather?"
var DAILY_URL = "forecast/daily?"
var LONGITUDE = "&lon="
var LATITUDE = "lat="
var API_KEY = "&appid=d7ae4a26351008b298356f9eb8f30ef6"
var COUNT = "&cnt=10"

typealias downloadCompleted = () -> ()
let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER_URL)\(LATITUDE)14.3\(LONGITUDE)15.1\(API_KEY)"
let FORECAST_URL = "\(BASE_URL)\(DAILY_URL)\(LATITUDE)14.3\(LONGITUDE)15.1\(API_KEY)\(COUNT)"