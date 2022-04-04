//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @State var showPortfolio: Bool = false
    @State var search: String = ""
    
    var body: some View {
        ZStack {
            Color.Theme.background
                .ignoresSafeArea()
            VStack {
                Header(showPortfolio: $showPortfolio)
                    .padding(.horizontal)
                
                SearchBar(text: $search)
                    .padding()
                
                HStack {
                    Text("Coin")
                    Spacer()
                    if showPortfolio {
                        Text("Holdings")
                    }
                    Text("Price")
                        .frame(width: UIScreen.main.bounds.width / 3.5)
                }
                .font(.caption)
                .foregroundColor(Color.Theme.secondaryText)
                .padding(.horizontal)
                
                if showPortfolio {
                    CoinList(coins: homeVM.portfolioCoins, showPortfolio: true)
                        .transition(.move(edge: .trailing))
                }
                if !showPortfolio {
                    CoinList(coins: filteredCoins, showPortfolio: false)
                        .transition(.move(edge: .leading))
                }
            }
        }
        .task {
            await homeVM.fetchCoins()
        }
    }
    
    var filteredCoins: [Coin] {
        if search.isEmpty {
            return homeVM.allCoins
        } else {
            return homeVM.allCoins.filter {
                $0.name.lowercased().contains(search.lowercased()) ||
                $0.id.lowercased().contains(search.lowercased()) ||
                $0.symbol.lowercased().contains(search.lowercased())
            }
        }
    }
}



struct Previews_HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
        HomeView()
            .environmentObject(HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
