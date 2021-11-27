//
//  WeatherTableViewCell.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/27/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highValueLabel: UILabel!
    @IBOutlet weak var lowValueLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    
    var presenter: WeatherPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(data: DailyWeather?) {
        guard let data = data else {
            return
        }
        if let doubleValueDate = Double(data.date) {
            let date = Date(timeIntervalSince1970: doubleValueDate)
            dayLabel.text = Utilities.shared.getDayFromDate(date)
        }
        if let doubleValueDate = Double(data.sunset) {
            let date = Date(timeIntervalSince1970: doubleValueDate)
            sunSetLabel.text = Utilities.shared.getTimeFromDate(date)
        }
        if let doubleValueDate = Double(data.sunrise) {
            let date = Date(timeIntervalSince1970: doubleValueDate)
            sunRiseLabel.text = Utilities.shared.getTimeFromDate(date)
        }
        weatherIcon.image = UIImage(named: "cloudy")
        highValueLabel.text = presenter?.setTemperatureBasedOnSelectedDegree(temp: data.temperatureHigh)
        lowValueLabel.text = presenter?.setTemperatureBasedOnSelectedDegree(temp: data.temperatureLow)
    }
}
