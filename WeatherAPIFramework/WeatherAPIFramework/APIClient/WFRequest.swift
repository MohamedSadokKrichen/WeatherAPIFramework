//
//  WFService.swift
//  WeatherAPIFramework
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import Foundation


final class WFRequest {
    private let endPoint: WFEndPoint
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endPoint: WFEndPoint, queryParameters: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmerd = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        
        if trimmerd.contains("?") {
            let components = trimmerd.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let wfEndpoint = WFEndPoint(rawValue: endpointString) {
                    self.init(endPoint: wfEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}
