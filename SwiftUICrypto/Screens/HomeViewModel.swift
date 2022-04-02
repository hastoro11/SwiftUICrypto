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
    init() {
        portfolioCoins = [TestData.coin(0), TestData.coin(3), TestData.coin(5)]
    }

    @MainActor
    func fetchCoins() async {
        if Task.isCancelled { return }
        do {
            self.allCoins = try await NetworkService.getCoins()
        } catch {
            print(error)
        }
    }
}

