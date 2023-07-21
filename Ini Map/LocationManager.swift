//
//  LocationManager.swift
//  Ini Map
//
//  Created by Muhammad Rifqy Fimanditya on 17/05/23.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    @Published var location: CLLocation?
    let view = MKMapView()
    private let locationManager = CLLocationManager()
        
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        view.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
        locationManager.stopUpdatingLocation()
    }
}
