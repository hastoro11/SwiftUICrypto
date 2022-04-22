//
//  CoinDetailsViewModel.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 22..
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    
    @Published var coin: Coin
    @Published var overviewStats: [Statistic] = []
    @Published var additionalStats: [Statistic] = []
    
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    @MainActor
    func fetch() async {
        let request = CoinDetailRequest(coin.id)
        let coinDetail = await request.execute() ?? CoinDetail.default
        self.overviewStats = createOverviewStat(coin: self.coin)
        self.additionalStats = createAdditionalStat(coin: self.coin, coinDetail: coinDetail)
    }
    
    func createOverviewStat(coin: Coin) -> [Statistic] {
        return [
            Statistic(
                title: "Current Price",
                value: coin.currentPrice.currencyFormatted(digits: 2),
                percentageChange: coin.priceChangePercentage24H),
            Statistic(
                title: "Market Capitalization",
                value: "$" + (coin.marketCap?.formattedWithAbbreviations() ?? ""),
                percentageChange: coin.marketCapChangePercentage24H ?? 0.0),
            Statistic(
                title: "Rank",
                value: String(coin.rank)),
            Statistic(
                title: "Volume",
                value: "$" + (coin.totalVolume ?? 0).formattedWithAbbreviations())
        ]
    }
    
    func createAdditionalStat(coin: Coin, coinDetail: CoinDetail) -> [Statistic] {
        return [
            Statistic(title: "24h High", value: (coin.high24H ?? 0).currencyFormatted(digits: 2)),
            Statistic(title: "24h Low", value: (coin.low24H ?? 0).currencyFormatted(digits: 2)),
            Statistic(
                title: "24h Price Change",
                value: (coin.priceChange24H ?? 0).currencyFormatted(digits: 6),
                percentageChange: (coin.priceChangePercentage24H)
            ),
            Statistic(
                title: "24h Market Cap Change",
                value: (coin.marketCapChange24H ?? 0).formattedWithAbbreviations(),
                percentageChange: (coin.marketCapChangePercentage24H)
            ),
            Statistic(
                title: "Block Time",
                value: coinDetail.blockTimeInMinutes == nil ? "n/a" : coinDetail.blockTimeInMinutes == 0 ? "n/a" : String(coinDetail.blockTimeInMinutes!)),
            Statistic(
                title: "Hashing Algorithm",
                value: coinDetail.hashingAlgorithm  ?? "n/a")
        ]
    }
    
    // MARK: - Preview
    static var preview: CoinDetailsViewModel {
        let vm = CoinDetailsViewModel(TestData.coin(0))
        vm.overviewStats = vm.createOverviewStat(coin: vm.coin)
        
        return vm
    }
}
