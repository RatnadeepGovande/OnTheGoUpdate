//
//  GenericAPIClient.swift
//  OnTheGo
//
//  Created by philips on 12/10/18.
//  Copyright © 2018 R. All rights reserved.
//

import Foundation

enum  APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsccessful: return "Response Unsuccessfull"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIClient {
    var session: URLSession{get}
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping(Decodable)-> T?, completion: @escaping(Result<T, APIError>) -> Void)
}
