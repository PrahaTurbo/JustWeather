//
//  APIService.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import Foundation

struct APIService  {
    
    static let shared = APIService()
    
    enum ServiceError: Error {
        case badUrl
        case fetchFailed
        case decodeFailed
    }
    
    func fetchData<T: Codable>(url: URL?) async throws -> T {
                
        guard let url = url else {
            throw ServiceError.badUrl
        }
                
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw ServiceError.fetchFailed
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
                
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw ServiceError.decodeFailed
        }
    }
}
