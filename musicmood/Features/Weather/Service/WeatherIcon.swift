//
//  WeatherIcon.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import Foundation

enum WeatherIcon {
    static func url(for code: String) -> URL {
        guard let url = URL(string: "http://localhost:5125/icons/\(code).png") else {
            fatalError("Couldn't create \(Self.Type.self) url")
        }
        return url
    }
}
