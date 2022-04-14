//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var stats: [Statistic] = []
    
    @Published var isMarketDataLoading: Bool = false
    @Published var isCoinDataLoading: Bool = false
    
    var dataService: PortfolioDataService = PortfolioDataService()

    func update(coin: Coin, amount: Double) {
        dataService.updatePortfolio(coin: coin, amount: amount)
        fetchPortfolioCoins()
    }

    @MainActor
    func fetchCoins() async {
        if Task.isCancelled { return }
        isCoinDataLoading = true
        defer { isCoinDataLoading = false }
        do {
            self.allCoins = try await NetworkService.getCoins()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchMarketData() async {
        if Task.isCancelled { return }
        isMarketDataLoading = true
        defer { isMarketDataLoading = false }
        do {
            self.stats = try await NetworkService.getMarketData()
        } catch {
            print(error)
        }
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
}

