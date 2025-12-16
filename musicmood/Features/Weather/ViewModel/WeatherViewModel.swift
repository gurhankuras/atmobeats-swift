//
//  WeatherViewModel.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import Combine
import CoreLocation
import Foundation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager: CLLocationManager
    let service: WeatherService

    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var currentLocation: CLLocation?
    @Published var weatherResponse: WeatherResponse?

    @Published var showFailedDialog: Bool = false

    init(
        service: WeatherService,
        locationManager: CLLocationManager
    ) {
        self.service = service
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }

    private func startUpdating() {
        locationManager.startUpdatingLocation()
    }

    private func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }

    func requestWhenInUsePermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestAlwaysPermission() {
        locationManager.requestAlwaysAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse
            || authorizationStatus == .authorizedAlways
        {
            showFailedDialog = false
            startUpdating()
        } else {
            showFailedDialog = true
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        print("fail")
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        currentLocation = locations.last
        stopUpdating()
        if let latitude = currentLocation?.coordinate.latitude,
           let longitute = currentLocation?.coordinate.longitude
        {
            service.getWeather(latitude: latitude, longitude: longitute) { result in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if case let .success(res) = result {
                        weatherResponse = res
                    }
                }
            }
        }
    }
}
