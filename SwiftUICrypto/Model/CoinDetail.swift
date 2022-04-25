//
//  CoinDetail.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 22..
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coinDetail = try? newJSONDecoder().decode(CoinDetail.self, from: jsonData)

import Foundation

// MARK: - CoinDetail
struct CoinDetail: Codable {
    let id, symbol, name: String
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, links, description
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        
    }
    
    static var`default`: CoinDetail {
        CoinDetail(id: "", symbol: "", name: "", blockTimeInMinutes: nil, hashingAlgorithm: "", description: Description(en: ""), links: Links(homepage: [], subredditURL: ""))
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String
}


// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?


    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"

    }
}
