//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 15..
//

import SwiftUI

class CoinListViewModel: ObservableObject {
    @Published var isLoading = false
    
    @MainActor
    func fetchCoins() async -> [Coin]? {
        isLoading = true
        defer { isLoading = false }
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")!
        let coinRequest = CoinRequest(url)
        return await coinRequest.execute()
    }
}

class MarketDataViewModel: ObservableObject {
    @Published var isLoading = false
    
    @MainActor
    func fetchMarketData() async -> [Statistic]? {
        isLoading = true
        defer { isLoading = false }
        let url = URL(string: "https://api.coingecko.com/api/v3/global")!
        let marketDataRequest = MarketDataRequest(url)
        let globalMarketData = await marketDataRequest.execute()
        
        guard let marketData = globalMarketData?.data else { return nil }
        return Statistic.convertMarketData(marketData)
    }
}
