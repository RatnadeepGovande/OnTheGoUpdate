//
//  HTTPTask.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/9/19.
//  Copyright © 2019 R. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters:Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, additoinHeaders: HTTPHeaders?)
}
