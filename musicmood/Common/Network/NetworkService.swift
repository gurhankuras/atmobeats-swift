//
//  NetworkService.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

import Foundation

// MARK: - Network Service

final class NetworkService {
    static let shared = NetworkService()

    private var baseURL: String {
        AppEnvironment.current.url
    }

    private let session: URLSession

    private init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Generic Request Method

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        // 1. URL oluştur
        guard var urlComponents = URLComponents(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        // 2. Request oluştur
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        request.setValue(languageCode, forHTTPHeaderField: "Accept-Language")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Custom headers ekle
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Body ekle (varsa)
        if let body {
            request.httpBody = try? JSONEncoder().encode(body)
        }

        // 3. Request yap
        let (data, response) = try await session.data(for: request)

        // 4. Response kontrolü
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200 ... 299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }

        // 5. Decode
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

    // MARK: - Completion Handler Version (backward compatibility)

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        Task {
            do {
                let result: T = try await request(
                    endpoint: endpoint,
                    method: method,
                    queryItems: queryItems,
                    body: body,
                    headers: headers
                )
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
