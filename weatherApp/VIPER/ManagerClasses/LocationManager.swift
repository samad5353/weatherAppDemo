//
//  LocationManager.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/26/21.
//

import Foundation
import CoreLocation

@objc protocol LocationDelegate: AnyObject {
    @objc optional func locationUpdated()
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var locationName = ""
    weak var delegate: LocationDelegate?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locManager.stopUpdatingLocation()
            guard let locations = locations.first else { return }
            self.getPlace(for: locations) { place in
                self.locationName = place?.name ?? "-"
                self.delegate?.locationUpdated?()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Log.error(error)
    }
    
}

// MARK: - Core Location Delegate
extension LocationManager {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined         : print("notDetermined")        // location permission not asked for yet
        case .authorizedWhenInUse   : print("authorizedWhenInUse")  // location authorized
        case .authorizedAlways      : print("authorizedAlways")     // location authorized
        case .restricted            : print("restricted")           // TODO: handle
        case .denied                : print("denied")               // TODO: handle
        default:
            print("")
        }
    }
}
// MARK: - Get Placemark
extension LocationManager {
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                Log.error(error)
                completion(nil)
                return
            }
            guard let placemark = placemarks?[0] else {
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
}
