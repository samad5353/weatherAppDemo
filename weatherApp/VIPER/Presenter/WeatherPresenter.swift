//
//  WeatherPresenter.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/26/21.
//

import Foundation

@objc protocol WeatherDelegate: AnyObject {
    @objc optional func reloadAfterAPICall()
}

class WeatherPresenter: LocationDelegate {
    let appID = "406d3e875de46e43e5d243a651c9f838"
    var latitude: Double? = 0.0
    var longitude: Double? = 0.0
    var weatherData: WeatherCodable?
    weak var delegate: WeatherDelegate?
    
    init() {
        LocationManager.shared.delegate = self
    }
    
    func locationUpdated() {
        makeWeatherAPICall()
    }
    
    private func makeWeatherAPICall() {
        self.latitude = LocationManager.shared.currentLocation?.coordinate.latitude
        self.longitude = LocationManager.shared.currentLocation?.coordinate.longitude
        
        let url = String(format: APPURL.Weather.oneLoginForForcast, 25.302810, 55.384792, appID)
        Log.info(url)
        NetworkManager.shared.makeAPI(urlString: url) { (result: WeatherCodable?) in
            self.weatherData = result
            self.delegate?.reloadAfterAPICall?()
        }
    }
}
