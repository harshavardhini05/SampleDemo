//
//  Country.swift
//  DemoProject
//
//  Created by HarshaVardhini on 12/01/19.
//  Copyright © 2019 HarshaVardhini. All rights reserved.
//

import Foundation

struct Country {
    let  id : String
    let imageUrl: URL
    let imageStr: String
    let name: String
}

extension Country: Decodable {
    enum CountryCodingKeys: String, CodingKey {
        case id
        case imageStr = "image"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let countryContainer = try decoder.container(keyedBy: CountryCodingKeys.self)
        id  = try countryContainer.decode(String.self, forKey: .id)
        imageStr = try countryContainer.decode(String.self, forKey: .imageStr)
        imageUrl = URL(string: imageStr)!
        name = try countryContainer.decode(String.self, forKey: .name)
    }
}
