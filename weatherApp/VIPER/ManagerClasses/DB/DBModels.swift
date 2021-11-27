//
//  DBModels.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/27/21.
//

import Foundation
import RealmSwift

// MARK: - SMS
class CurrentWeather: Object {
    @objc dynamic var date = ""
    @objc dynamic var sunrise = ""
    @objc dynamic var sunset = ""
    @objc dynamic var temperature = ""
    @objc dynamic var feelsLike = ""
    @objc dynamic var humidity = ""
    @objc dynamic var weatherDescription = ""
    @objc dynamic var weatherMain = ""
    @objc dynamic var compoundKey = ""
    override class func primaryKey() -> String? {
        return "compoundKey"
    }
}

class HourlyWeather: Object {
    @objc dynamic var date = ""
    @objc dynamic var sunrise = ""
    @objc dynamic var sunset = ""
    @objc dynamic var temperature = ""
    @objc dynamic var feelsLike = ""
    @objc dynamic var humidity = ""
    @objc dynamic var weatherDescription = ""
    @objc dynamic var weatherMain = ""
    @objc dynamic var compoundKey = ""
    override class func primaryKey() -> String? {
        return "compoundKey"
    }
}

class DailyWeather: Object {
    @objc dynamic var date = ""
    @objc dynamic var sunrise = ""
    @objc dynamic var sunset = ""
    @objc dynamic var temperatureLow = ""
    @objc dynamic var temperatureHigh = ""
    @objc dynamic var humidity = ""
    @objc dynamic var weatherDescription = ""
    @objc dynamic var weatherMain = ""
    @objc dynamic var compoundKey = ""
    override class func primaryKey() -> String? {
        return "compoundKey"
    }
}
