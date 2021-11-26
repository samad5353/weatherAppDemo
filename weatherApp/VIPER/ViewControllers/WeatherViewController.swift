//
//  ViewController.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/26/21.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    var presenter: WeatherPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherPresenter()
        presenter?.delegate = self
    }
}

extension WeatherViewController: WeatherDelegate {
    func reloadAfterAPICall() {
        temperatureLabel.text = "\(presenter?.weatherData?.current?.temp ?? 0)"
        summaryLabel.text = presenter?.weatherData?.current?.weather?.first?.main
        placeName.text = LocationManager.shared.locationName
        tableView.reloadData()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Hourly Forecast"
        }
        return "7-Day Forecast"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return presenter?.weatherData?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        return cell
    }
}
