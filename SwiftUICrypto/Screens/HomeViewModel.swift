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
    init() {
        portfolioCoins = [TestData.coin(0), TestData.coin(3), TestData.coin(5)]
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
}

