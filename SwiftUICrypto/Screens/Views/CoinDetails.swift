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
        @StateObject var vm: CoinDetailsViewModel = CoinDetailsViewModel()
        @State var showLongDescription = false
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {                    
                    ChartView(data: coin.sparklineIn7D?.price ?? [], updatedDate: coin.lastUpdated ?? "")
                        .frame(height: 300)
                    
                    Text("Overview")
                        .font(.title.bold())
                        .foregroundColor(Color.accentColor)
                    Divider()
                    
                    if let desc = vm.description {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(desc)
                                .lineLimit(showLongDescription ? nil : 5)
                                .foregroundColor(Color.Theme.secondaryText)
                                .font(.callout)
                                .animation(showLongDescription ? .default : .none, value: showLongDescription)
                            Button(action: {
                                withAnimation {
                                    showLongDescription.toggle()
                                }
                            }) {
                                Text(showLongDescription ? "Read less" : "Read more")
                            }
                            .foregroundColor(Color.blue)
                        }
                    }
                    
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
                    Divider()
                    
                    if let homePageLink = vm.homePageLink, let homeUrl = URL(string: homePageLink) {
                        Link("Homepage", destination: homeUrl)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .navigationTitle(coin.name)
                .task {
                    await vm.fetch(coin: coin)
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
