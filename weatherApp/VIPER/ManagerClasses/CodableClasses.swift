//
//  CodableClasses.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/26/21.
//

import Foundation

// MARK: - WeatherCodable
class WeatherCodable: Codable {
    var lat, lon: Double?
    var timezone: String?
    var timezoneOffset: Int?
    var current: Current?
    var hourly: [Current]?
    var daily: [Daily]?
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
    
    init(lat: Double?, lon: Double?, timezone: String?, timezoneOffset: Int?, current: Current?, hourly: [Current]?, daily: [Daily]?) {
        self.lat = lat
        self.lon = lon
        self.timezone = timezone
        self.timezoneOffset = timezoneOffset
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
}

// MARK: - Current
class Current: Codable {
    var dt, sunrise, sunset: Int?
    var temp, feelsLike: Double?
    var pressure, humidity: Int?
    var dewPoint, uvi: Double?
    var clouds, visibility: Int?
    var windSpeed: Double?
    var windDeg: Int?
    var weather: [Weather]?
    var windGust: Double?
    var pop: Int?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
        case windGust = "wind_gust"
        case pop
    }
    
    init(dt: Int?, sunrise: Int?, sunset: Int?, temp: Double?, feelsLike: Double?, pressure: Int?, humidity: Int?, dewPoint: Double?, uvi: Double?, clouds: Int?, visibility: Int?, windSpeed: Double?, windDeg: Int?, weather: [Weather]?, windGust: Double?, pop: Int?) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.dewPoint = dewPoint
        self.uvi = uvi
        self.clouds = clouds
        self.visibility = visibility
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.weather = weather
        self.windGust = windGust
        self.pop = pop
    }
}

// MARK: - Weather
class Weather: Codable {
    var id: Int?
    var main: String?
    var weatherDescription: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    init(id: Int?, main: String?, weatherDescription: String?, icon: String?) {
        self.id = id
        self.main = main
        self.weatherDescription = weatherDescription
        self.icon = icon
    }
}

// MARK: - Daily
class Daily: Codable {
    var dt, sunrise, sunset, moonrise: Int?
    var moonset: Int?
    var moonPhase: Double?
    var temp: Temp?
    var feelsLike: FeelsLike?
    var pressure, humidity: Int?
    var dewPoint, windSpeed: Double?
    var windDeg: Int?
    var windGust: Double?
    var weather: [Weather]?
    var clouds: Int?
    var pop, uvi: Double?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi
    }
    
    init(dt: Int?, sunrise: Int?, sunset: Int?, moonrise: Int?, moonset: Int?, moonPhase: Double?, temp: Temp?, feelsLike: FeelsLike?, pressure: Int?, humidity: Int?, dewPoint: Double?, windSpeed: Double?, windDeg: Int?, windGust: Double?, weather: [Weather]?, clouds: Int?, pop: Double?, uvi: Double?) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moonPhase = moonPhase
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.dewPoint = dewPoint
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.windGust = windGust
        self.weather = weather
        self.clouds = clouds
        self.pop = pop
        self.uvi = uvi
    }
}

// MARK: - FeelsLike
class FeelsLike: Codable {
    var day, night, eve, morn: Double?
    
    init(day: Double?, night: Double?, eve: Double?, morn: Double?) {
        self.day = day
        self.night = night
        self.eve = eve
        self.morn = morn
    }
}

// MARK: - Temp
class Temp: Codable {
    var day, min, max, night: Double?
    var eve, morn: Double?
    
    init(day: Double?, min: Double?, max: Double?, night: Double?, eve: Double?, morn: Double?) {
        self.day = day
        self.min = min
        self.max = max
        self.night = night
        self.eve = eve
        self.morn = morn
    }
}


