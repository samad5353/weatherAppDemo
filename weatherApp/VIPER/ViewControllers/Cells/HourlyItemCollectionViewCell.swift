//
//  HourlyCollectionViewCell.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/27/21.
//

import UIKit

class HourlyItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var presenter: WeatherPresenter?
    
    func setCell(data: HourlyWeather?) {
        guard let data = data else {
            return
        }
        if let doubleValueDate = Double(data.date) {
            let date = Date(timeIntervalSince1970: doubleValueDate)
            timeLabel.text = Utilities.shared.getHourFromDate(date)
        }
        
        tempLabel.text = presenter?.setTemperatureBasedOnSelectedDegree(temp: data.temperature)
    }
}
