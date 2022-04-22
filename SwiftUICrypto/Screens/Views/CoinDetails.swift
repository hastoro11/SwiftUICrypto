//
//  CoinDetails.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 22..
//

import SwiftUI



struct CoinDetails: View {
    var coin: Coin?
    var body: some View {
        if let coin = coin {
            Content(coin: coin)
        }
    }
}

extension CoinDetails {
    struct Content: View {
        var coin: Coin
        @StateObject var vm: CoinDetailsViewModel
        init(coin: Coin) {
            self.coin = coin
            _vm = StateObject(wrappedValue: CoinDetailsViewModel(coin))
        }
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("")
                        .frame(height: 150)
                    
                    Text("Overview")
                        .font(.title.bold())
                        .foregroundColor(Color.accentColor)
                    Divider()
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), alignment: .leading, spacing: 20, pinnedViews: []) {
                        ForEach(vm.overviewStats) { stat in
                            StatisticCell(stat: stat)
                        }
                    }
                    
                    Text("Additional Details")
                        .font(.title.bold())
                        .foregroundColor(Color.accentColor)
                    Divider()
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), alignment: .leading, spacing: 20, pinnedViews: []) {
                        ForEach(vm.additionalStats) { stat in
                            StatisticCell(stat: stat)
                        }
                    }
                }
                .padding()
                .navigationTitle(coin.name)
                .task {
                    await vm.fetch()
                }
            }
        }
    }
}

struct CoinDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinDetails.Content(coin: TestData.coin(23))
        }
        
        NavigationView {
            CoinDetails.Content(coin: TestData.coin(23))
        }
        .preferredColorScheme(.dark)
    }
}
