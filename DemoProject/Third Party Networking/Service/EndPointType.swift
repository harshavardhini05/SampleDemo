//
//  EndPointType.swift
//  MyContacts
//
//  Created by HarshaVardhini on 1/8/19.
//  Copyright © 2019 HarshaVardhini. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
