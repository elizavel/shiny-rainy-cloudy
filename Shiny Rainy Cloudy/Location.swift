//
//  Location.swift
//  Shiny Rainy Cloudy
//
//  Created by Eliza Vel Rosario on 21/08/2018.
//  Copyright © 2018 Eliza Velcom.eliza. All rights reserved.
//

import CoreLocation


class Location {
    
    static var sharedInstance = Location()
    private init(){}
    
    
    var latitude: Double!
    var longitude: Double!
    
    
}