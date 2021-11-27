//
//  WeatherPresenter.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/26/21.
//

import Foundation

@objc protocol WeatherDelegate: AnyObject {
    @objc optional func reloadAfterAPICall()
    @objc optional func moveToDetailPage()
}

enum SelectedDegree {
    case celcius
    case fahrenHeat
}

class WeatherPresenter: LocationDelegate {
    let appID = "406d3e875de46e43e5d243a651c9f838"
    var latitude: Double? = 0.0
    var longitude: Double? = 0.0
    var currentWeatherData: CurrentWeather? {
        return DBManager.shared.getObjects(CurrentWeather.self)?.first
    }
    var dailyWeatherData: [DailyWeather]? {
        return DBManager.shared.getObjects(DailyWeather.self)
    }
    var hourlyWeatherData: [HourlyWeather]? {
        return DBManager.shared.getObjects(HourlyWeather.self)
    }
    var selectedData: DailyWeather?
    var selectedDegree: SelectedDegree = .celcius
    
    weak var delegate: WeatherDelegate?
    
    init() {
        LocationManager.shared.delegate = self
    }
    
    func locationUpdated() {
        makeWeatherAPICall()
    }
    
    func setSelectedDate(data: DailyWeather?) {
        self.selectedData = data
        self.delegate?.moveToDetailPage?()
    }
    
    func setTemperatureBasedOnSelectedDegree(temp: String) -> String {
        if selectedDegree == .fahrenHeat {
            let temp = ((Double(temp) ?? 0) * 1.8) + 32
            let roundedFH = String(format: "%.f", temp)
            return "\(roundedFH)°"
        }
        return "\(temp)°"
    }
    
    private func makeWeatherAPICall() {
        self.latitude = LocationManager.shared.currentLocation?.coordinate.latitude
        self.longitude = LocationManager.shared.currentLocation?.coordinate.longitude
        
        let url = String(format: APPURL.Weather.oneLoginForForcast, self.latitude ?? 0.0, self.longitude ?? 0.0, appID)
        Log.info(url)
        NetworkManager.shared.makeAPI(urlString: url) { (result: WeatherCodable?) in
            self.saveCurrentWeatherDetails(weather: result)
            self.saveDailyWeatherDetails(weather: result?.daily)
            self.saveHourlyWeatherDetails(weather: result?.hourly)
        }
    }
    
    private func saveCurrentWeatherDetails(weather: WeatherCodable?) {
        guard let weather = weather else {
            return
        }
        DBManager.shared.clearTable(CurrentWeather.self)
        let singleObj = CurrentWeather()
        
        if let value = weather.current?.temp {
            let roundedCelcius = String(format: "%.f", value)
            singleObj.temperature = String(roundedCelcius)
        }
        if let value = weather.current?.dt {
            singleObj.date = String(value)
        }
        if let value = weather.current?.sunrise {
            singleObj.sunrise = String(value)
        }
        if let value = weather.current?.sunset {
            singleObj.sunset = String(value)
        }
        if let value = weather.current?.feelsLike {
            singleObj.feelsLike = String(value)
        }
        if let value = weather.current?.humidity {
            singleObj.humidity = String(value)
        }
        
        if let value = weather.current?.weather?.first?.main {
            singleObj.weatherMain = value
        }
        
        if let value = weather.current?.weather?.first?.weatherDescription {
            singleObj.weatherDescription = value
        }
        
        singleObj.compoundKey = singleObj.date + "**" + singleObj.sunset + "**" + singleObj.sunrise
        DBManager.shared.saveObject(singleObject: singleObj)
    }
    
    private func saveDailyWeatherDetails(weather: [Daily]?) {
        guard let weather = weather else {
            return
        }
        DBManager.shared.clearTable(DailyWeather.self)
        var arrayToSave = [DailyWeather]()
        for each in weather {
            let singleObj = DailyWeather()
            if let value = each.temp?.min {
                let roundedCelcius = String(format: "%.f", value)
                singleObj.temperatureLow = String(roundedCelcius)
            }
            if let value = each.temp?.max {
                let roundedCelcius = String(format: "%.f", value)
                singleObj.temperatureHigh = String(roundedCelcius)
            }
            if let value = each.dt {
                singleObj.date = String(value)
            }
            if let value = each.sunrise {
                singleObj.sunrise = String(value)
            }
            if let value = each.sunset {
                singleObj.sunset = String(value)
            }
            if let value = each.humidity {
                singleObj.humidity = String(value)
            }
            
            if let value = each.weather?.first?.main {
                singleObj.weatherMain = value
            }
            
            if let value = each.weather?.first?.weatherDescription {
                singleObj.weatherDescription = value
            }
            
            singleObj.compoundKey = singleObj.date + "**" + singleObj.sunset + "**" + singleObj.sunrise
            arrayToSave.append(singleObj)
        }
        if arrayToSave.count > 0 {
            DBManager.shared.saveObject(objects: arrayToSave)
        }
    }
    
    private func saveHourlyWeatherDetails(weather: [Current]?) {
        guard let weather = weather else {
            return
        }
        DBManager.shared.clearTable(HourlyWeather.self)
        var arrayToSave = [HourlyWeather]()
        for each in weather {
            let singleObj = HourlyWeather()
            if let value = each.temp {
                let roundedCelcius = String(format: "%.f", value)
                singleObj.temperature = String(roundedCelcius)
            }
            if let value = each.feelsLike {
                singleObj.feelsLike = String(value)
            }
            if let value = each.dt {
                singleObj.date = String(value)
            }
            if let value = each.sunrise {
                singleObj.sunrise = String(value)
            }
            if let value = each.sunset {
                singleObj.sunset = String(value)
            }
            if let value = each.humidity {
                singleObj.humidity = String(value)
            }
            
            if let value = each.weather?.first?.main {
                singleObj.weatherMain = value
            }
            
            if let value = each.weather?.first?.weatherDescription {
                singleObj.weatherDescription = value
            }
            
            singleObj.compoundKey = singleObj.date + "**" + singleObj.sunset + "**" + singleObj.sunrise
            arrayToSave.append(singleObj)
        }
        if arrayToSave.count > 0 {
            DBManager.shared.saveObject(objects: arrayToSave)
        }
        self.delegate?.reloadAfterAPICall?()
    }
}
