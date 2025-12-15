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
            return "Geçersiz URL"
        case .invalidResponse:
            return "Geçersiz yanıt"
        case .serverError(let statusCode):
            return "Sunucu hatası: \(statusCode)"
        case .noData:
            return "Veri alınamadı"
        case .decodingError(let error):
            return "JSON parse hatası: \(error.localizedDescription)"
        case .requestFailed(let error):
            return "İstek başarısız: \(error.localizedDescription)"
        }
    }
}

