//
//  HTTPTask.swift
//  MyContacts
//
//  Created by HarshaVardhini on 1/8/19.
//  Copyright © 2019 HarshaVardhini. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    // case download, upload...etc
}
