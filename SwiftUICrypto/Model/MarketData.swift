//
//  MarketData.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 05..
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let globaMarketData = try? newJSONDecoder().decode(GlobaMarketData.self, from: jsonData)

// MARK: - GlobaMarketData
struct GlobaMarketData: Codable {
    let data: MarketData
}

// MARK: - MarketData
struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    var marketCap: Double {
        totalMarketCap["usd"] ?? 0.0
    }
    
    var total24hVolume: Double {
        totalVolume["usd"] ?? 0.0
    }
    
    var btcDominance: Double {
        marketCapPercentage["btc"] ?? 0.0
    }
}
