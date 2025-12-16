//
//  NetworkError.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

import Foundation

// MARK: - Network Error

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case requestFailed(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Geçersiz URL"
        case .invalidResponse:
            "Geçersiz yanıt"
        case let .serverError(statusCode):
            "Sunucu hatası: \(statusCode)"
        case .noData:
            "Veri alınamadı"
        case let .decodingError(error):
            "JSON parse hatası: \(error.localizedDescription)"
        case let .requestFailed(error):
            "İstek başarısız: \(error.localizedDescription)"
        }
    }
}
