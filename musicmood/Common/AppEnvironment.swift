//
//  Environment.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//


enum AppEnvironment {
    static var current: AppEnvironment {
        return .prod
    }

    case dev
    case prod
    
    
    var url: String {
        switch self {
        case .dev:
            return "http://localhost:5125"
        case .prod:
            return "https://musicmood-f0efekhjcxb5dpes.westeurope-01.azurewebsites.net"
        }
    }
}
