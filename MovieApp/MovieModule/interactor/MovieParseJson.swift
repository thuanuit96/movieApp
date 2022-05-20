//
// MovieParseJson.swift
// MovieApp
//
// Created by VN01-MAC-0006 on 18/05/2022.
//
//


import Foundation

class MovieParseJson: NSObject, MovieParse {
    
    func parseData(data: Data, completionHandler: @escaping ((Result<ResponseData>) -> Void)) {
        let decoder = JSONDecoder()
        do {
            let reponseData = try decoder.decode(ResponseData.self, from: data)
            completionHandler(.success(reponseData))
        } catch {
            print("parse data error : \(error)")
            completionHandler(.failure(error))
        }
      
    }
}
