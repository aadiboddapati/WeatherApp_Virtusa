//
//  LocationPermissionHandler.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import Foundation
import CoreLocation

class LocationPermissionHandler: NSObject {
    static let shared: LocationPermissionHandler = LocationPermissionHandler()
    private var locManager = CLLocationManager()
    private override init() {
        super.init()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
    }
    
    func checkLocationPermissionAccess() -> Bool {
        guard locManager.authorizationStatus == .authorizedWhenInUse || locManager.authorizationStatus == .authorizedAlways else {
            locManager.requestWhenInUseAuthorization()
            return false
        }
        return true
    }
    
}

extension LocationPermissionHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _ = locations.first else { return }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            print( "Failed to get location: \(error.localizedDescription)")
        }
    }
}
