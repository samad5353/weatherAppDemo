//
//  WeatherDetailsViewController.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/27/21.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    var presenter: WeatherPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        if let doubleValueDate = Double(presenter?.selectedData?.sunset ?? "") {
            let date = Date(timeIntervalSince1970: doubleValueDate)
            sunsetLabel.text = Utilities.shared.getTimeFromDate(date)
        }
        if let doubleValueDate = Double(presenter?.selectedData?.sunrise ?? "") {
            let date = Date(timeIntervalSince1970: doubleValueDate)
            sunriseLabel.text = Utilities.shared.getTimeFromDate(date)
        }
        humidityLabel.text = "\(presenter?.selectedData?.humidity ?? "-") %"
    }
    
    @IBAction func backButtonClicked(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
}
