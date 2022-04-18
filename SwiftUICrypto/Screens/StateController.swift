//
//  StateController.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

class StateController: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var stats: [Statistic] = []
    
    @Published var isLoading = false
    @Published var isErrorHappened = false
    
    var dataService: PortfolioDataService = PortfolioDataService()

    func update(coin: Coin, amount: Double) {
        dataService.updatePortfolio(coin: coin, amount: amount)
        fetchPortfolioCoins()
    }
    
    func fetchPortfolioCoins(){        
        let entities = dataService.fetchPortfolio()
        let portfolios = allCoins.compactMap { coin -> Coin? in
            if let entity = entities.first(where: {$0.coinID == coin.id}) {
                return coin.updateHoldings(amount: entity.amount)
            }
            return nil
        }
        portfolioCoins = portfolios
    }
    
    func fetchAmountFor(_ coin: Coin) -> Double {
        let entities = dataService.fetchPortfolio()
        if let entity = entities.first(where: {$0.coinID == coin.id }) {
            return entity.amount
        }
        return 0
    }
    
    @MainActor
    func fetch() async {
        isLoading = true
        defer { isLoading = false }
        async let coinsReq = fetchCoins()
        async let statsReq = fetchMarketData()
        var (coins, stats) = await (coinsReq, statsReq)
        if let portfolioVolumeStat = calculatePortfolio(coins: coins) {
            stats?.append(portfolioVolumeStat)
        }
        guard let coins = coins, let stats = stats else {
            isErrorHappened = true
            return
        }
        self.allCoins = coins
        self.stats = stats
    }
    
    private func fetchMarketData() async -> [Statistic]? {
        let url = URL(string: "https://api.coingecko.com/api/v3/global")!
        let marketDataRequest = MarketDataRequest(url)
        let globalMarketData = await marketDataRequest.execute()
        
        guard let marketData = globalMarketData?.data else { return nil }
        return Statistic.convertMarketData(marketData)
    }
    
    private func fetchCoins() async -> [Coin]? {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")!
        let coinRequest = CoinRequest(url)
        return await coinRequest.execute()
    }
    
    private func calculatePortfolio(coins: [Coin]?) -> Statistic? {
        guard let allCoins = coins else { return nil }
        let entities = dataService.fetchPortfolio()
        let portfolios = allCoins.compactMap { coin -> Coin? in
            if let entity = entities.first(where: {$0.coinID == coin.id}) {
                return coin.updateHoldings(amount: entity.amount)
            }
            return nil
        }
        
        let currentVolume = portfolios.reduce(0.0) { partialResult, coin in
            return partialResult + coin.currentHoldingsValue
        }
        
        let previousVolume = portfolios.reduce(0.0) { partialResult, coin in
            return partialResult + coin.currentHoldingsValue / (1 + (coin.priceChangePercentage24H ?? 0) / 100)
        }
        
        let percentageChange = ((currentVolume - previousVolume) / previousVolume) * 100
        
        return Statistic(title: "Portfolio Volume", value: currentVolume.currencyFormatted(digits:2), percentageChange: percentageChange)
    }
}

