//
//  LocationManager.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 11/05/2023.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D? {
        didSet {
            if let location {
                region = .init(center: location,
                               latitudinalMeters: 700,
                               longitudinalMeters: 700)
            }
        }
    }
    @Published var region: MKCoordinateRegion?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        if let location {
            region = .init(center: location,
                           latitudinalMeters: 700,
                           longitudinalMeters: 700)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
