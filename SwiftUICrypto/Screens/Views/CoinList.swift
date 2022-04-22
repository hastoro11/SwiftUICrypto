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
    @State var showDetails: Bool = false
    @State var selectedCoin: Coin?
    var body: some View {

        ZStack {
            NavigationLink(isActive: $showDetails) {
                CoinDetails(coin: selectedCoin)
            } label: {
                EmptyView()
            }
            List {
                ForEach(coins) { coin in
                    CoinRow(coin: coin, showCurrentHoldings: showPortfolio)
                        .onTapGesture {
                            selectedCoin = coin
                            showDetails.toggle()
                        }
                }
                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            .listStyle(.plain)
        }
    }
}

struct CoinList_Previews: PreviewProvider {
    static var coins = TestData.coins
    static var previews: some View {
        CoinList(coins: coins, showPortfolio: true)
    }
}
