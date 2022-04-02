//
//  CoinList.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct CoinList: View {
    var coins: [Coin]
    var showPortfolio: Bool
    var body: some View {
        List {
            ForEach(coins) { coin in
                CoinRow(coin: coin, showCurrentHoldings: showPortfolio)
            }
            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        }
        .listStyle(.plain)
    }
}

struct CoinList_Previews: PreviewProvider {
    static var coins = TestData.coins
    static var previews: some View {
        CoinList(coins: coins, showPortfolio: true)
    }
}
