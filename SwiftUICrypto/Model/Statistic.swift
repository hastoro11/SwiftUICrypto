//
//  Statistic.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 05..
//

import Foundation
import SwiftUI

struct Statistic: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: String
    var percentageChange: Double?
}

extension Statistic {
    static func convertMarketData(_ marketData: MarketData) -> [Statistic]? {
        var stats = [Statistic]()
        let marketCap = Statistic(
            title: "Market Cap",
            value: marketData.marketCap.formattedWithAbbreviations(),
            percentageChange: marketData.marketCapChangePercentage24HUsd)
        let total24hVolume = Statistic(title: "24h Volume", value: marketData.total24hVolume.formattedWithAbbreviations())
        let btcDominance = Statistic(title: "BTC Dominance", value: marketData.btcDominance.formattedWithAbbreviations())
        stats.append(marketCap)
        stats.append(total24hVolume)
        stats.append(btcDominance)
//        stats.append(Statistic(title: "Portfolio Volume", value: "$0.00"))
        
        return stats
    }
}
