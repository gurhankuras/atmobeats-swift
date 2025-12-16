//
//  MockWeatherService.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//
import Foundation

final class MockWeatherService: WeatherProvider {
    func getWeather(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<WeatherResponse, any Error>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(
                .success(
                    WeatherResponse(
                        description: "broken clouds",
                        icon: "11n",
                        city: "Uskudar",
                        unitType: "metric",
                        temperature: 12
                    )
                )
            )
        }
    }
}
