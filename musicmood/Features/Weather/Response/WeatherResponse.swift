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
            return "°C"
        case "imperial":
            return "°C"
        default:
            return ""
        }
    }
    
    var unitDisplay: String {
        return "\(temperature)\(unitSymbol)"
    }
    
    var iconName: String {
        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d", "03n":
            return "cloud.fill"
        case "04d", "04n":
            return "cloud.fill"
        case "09d", "09n":
            return "cloud.heavyrain.fill"
        case "10d", "10n":
            return "cloud.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.fill"
        case "13d", "13n":
            return "snowflake"
        case "50d", "50n":
            return "cloud.fog"
        default:
            return "questionmark.circle"
        }
    }

}
