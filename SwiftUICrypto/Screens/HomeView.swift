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
    var body: some View {
        ZStack {
            Color.Theme.background
                .ignoresSafeArea()
            VStack {
                Header(showPortfolio: $showPortfolio)
                    .padding(.horizontal)
                
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
                    CoinList(coins: homeVM.allCoins, showPortfolio: false)
                        .transition(.move(edge: .leading))
                }
            }
        }
        .task {
            await homeVM.fetchCoins()
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
