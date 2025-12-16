//
//  AppEnvironment.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

enum AppEnvironment {
    static var current: AppEnvironment {
        .prod
    }

    case dev
    case prod

    var url: String {
        switch self {
        case .dev:
            "http://localhost:5125"
        case .prod:
            "https://musicmood-f0efekhjcxb5dpes.westeurope-01.azurewebsites.net"
        }
    }
}
