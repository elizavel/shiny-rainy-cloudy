//
//  ViewController.swift
//  Shiny Rainy Cloudy
//
//  Created by Eliza Vel Rosario on 21/08/2018.
//  Copyright © 2018 Eliza Velcom.eliza. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var weatherTypeImg: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var TodayWeatherTableView: UITableView!
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    var todayForecast : TodayForecast!
    var dailyForecast : WeeklyForecast!
    var weeklyForecast : [WeeklyForecast] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        


        
        TodayWeatherTableView.delegate = self
        TodayWeatherTableView.dataSource = self
        todayForecast = TodayForecast()
        todayForecast.downloadWeatherToday{
            self.updateUI()
        }
       
        self.downloadWeeklyForecast{
        }
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //locationAuthStatus()
    }

    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = locationManager.location?.coordinate.latitude
            Location.sharedInstance.longitude = locationManager.location?.coordinate.longitude
            
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadWeeklyForecast (complete: downloadCompleted){
        
        print(FORECAST_URL)
        Alamofire.request(.GET,FORECAST_URL).responseJSON { response in
            //print(response.2.value)
            
            let apireturn = response.2.value
            
            if let dict = apireturn as? Dictionary<String,AnyObject>{
                
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    for obj in list{
                        let forecast = WeeklyForecast(weatherDict: obj)
                        self.weeklyForecast.append(forecast)
                        print(obj)
                    }
                    self.weeklyForecast.removeAtIndex(0)
                    self.TodayWeatherTableView.reloadData()
                }
            }
            
        }
    }

    
    
    func updateUI(){
        dateLbl.text = todayForecast.date
        tempLbl.text = "\(todayForecast.currentTemp)"
        cityNameLbl.text = todayForecast.cityName
        weatherTypeLbl.text = todayForecast.weatherType
        weatherTypeImg.image = UIImage(named: todayForecast.weatherType)
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weeklyForecast.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell", forIndexPath: indexPath) as? WeatherCell {
            let forecastCell = weeklyForecast[indexPath.row]
            cell.configureCell(forecastCell)
            return cell
        }else{
            return WeatherCell()
        }
        
    }

}

