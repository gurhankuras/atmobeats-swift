//
//  WeatherResponse.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

struct WeatherResponse: Decodable {
    let description: String
    let icon: String
    let city: String
    let unitType: String
    let temperature: Int

    var unitSymbol: String {
        switch unitType {
        case "metric":
            "°C"
        case "imperial":
            "°C"
        default:
            ""
        }
    }

    var unitDisplay: String {
        "\(temperature)\(unitSymbol)"
    }

    var iconName: String {
        switch icon {
        case "01d":
            "sun.max.fill"
        case "01n":
            "moon.fill"
        case "02d":
            "cloud.sun.fill"
        case "02n":
            "cloud.moon.fill"
        case "03d", "03n":
            "cloud.fill"
        case "04d", "04n":
            "cloud.fill"
        case "09d", "09n":
            "cloud.heavyrain.fill"
        case "10d", "10n":
            "cloud.rain.fill"
        case "11d", "11n":
            "cloud.bolt.fill"
        case "13d", "13n":
            "snowflake"
        case "50d", "50n":
            "cloud.fog"
        default:
            "questionmark.circle"
        }
    }
}
