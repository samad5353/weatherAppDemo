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
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var fLabel: UILabel!

    var presenter: WeatherPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherPresenter()
        presenter?.delegate = self
    }
    
    @IBAction func settingsClicked(_sender: UIControl) {
        self.performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    @IBAction func celciusClicked(_ sender: UIControl) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            // convert to fahren heat
            fLabel.textColor = .white
            cLabel.textColor = .secondaryLabel
            presenter?.selectedDegree = .fahrenHeat
        } else {
            // convert to celcius
            fLabel.textColor = .secondaryLabel
            cLabel.textColor = .white
            presenter?.selectedDegree = .celcius
        }
        reloadAfterAPICall()
    }
}

extension WeatherViewController: WeatherDelegate {
    func reloadAfterAPICall() {
        temperatureLabel.text = presenter?.setTemperatureBasedOnSelectedDegree(temp: presenter?.currentWeatherData?.temperature ?? "-")
        summaryLabel.text = presenter?.currentWeatherData?.weatherMain
        placeName.text = LocationManager.shared.locationName
        tableView.reloadData()
    }
    
    func moveToDetailPage() {
        self.performSegue(withIdentifier: "showDetails", sender: nil)
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
        return presenter?.dailyWeatherData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell", for: indexPath) as? HourlyTableViewCell else { return UITableViewCell() }
            cell.collectionView.reloadData()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
            cell.presenter = presenter
            cell.setCell(data: presenter?.dailyWeatherData?[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.setSelectedDate(data: presenter?.dailyWeatherData?[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius = 11
        var corners: UIRectCorner = []
        
        if indexPath.row == 0 {
            corners.update(with: .topLeft)
            corners.update(with: .topRight)
        }
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            corners.update(with: .bottomLeft)
            corners.update(with: .bottomRight)
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: cell.bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        cell.layer.mask = maskLayer
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.hourlyWeatherData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyItemCollectionViewCell", for: indexPath) as? HourlyItemCollectionViewCell else { return HourlyItemCollectionViewCell() }
        cell.presenter = presenter
        cell.setCell(data: presenter?.hourlyWeatherData?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.size.height)
    }
}

extension WeatherViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destinationVC = segue.destination as? WeatherDetailsViewController {
                destinationVC.presenter = self.presenter
            }
        }
    }
}
