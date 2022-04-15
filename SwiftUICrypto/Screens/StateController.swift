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
}

