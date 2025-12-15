//
//  WeatherProvider.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

protocol WeatherProvider {
    func getWeather(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<WeatherResponse, Error>) -> Void
    )
}
