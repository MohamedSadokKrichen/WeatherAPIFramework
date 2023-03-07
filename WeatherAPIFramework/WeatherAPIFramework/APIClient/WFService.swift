//
//  WFService.swift
//  WeatherAPIFramework
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import Foundation

final class WFService {
    
    public let shared = WFService()
    
    private init() {}
    
    /// Error definitions
    enum WFServiceError: Error {
        case faileToCreateRequest
        case failedToGetData
    }
    
    /// create our request
    /// - Parameter wfRequest: request created with WFRequest
    /// - Returns: urlRequest to execute it
    private func request(from wfRequest: WFRequest) -> URLRequest? {
        guard let url = wfRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = wfRequest.httpMethod
        return request
    }
    
    /// Send API Call
    /// - Parameters:
    ///   - request: request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: WFRequest,
                        completion: @escaping (Result<Weather, Error>) -> Void) {
        guard let urlrequest = self.request(from: request) else {
            completion(.failure(WFServiceError.faileToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlrequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? WFServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
