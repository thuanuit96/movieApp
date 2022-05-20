//
// ListMovieApiRequest.swift
// MovieApp
//
// Created by VN01-MAC-0006 on 18/05/2022.
//
//
import Foundation

class ListMovieApiRequest : ApiRequest {
    
    var page : Int?

   func setCurrentPage(page: Int) {
        self.page = page
    }
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var queryItems: [URLQueryItem]? {
        let queryItems = [URLQueryItem(name: "api_key", value: AppConfig.apiKey),
                          URLQueryItem(name: "page", value: String(page ?? 1))]
        return queryItems
        }
    
    var request: URLRequest? {
        return request(forEndpoint: EndpointPaths.fetchMove.rawValue)
    }
}



