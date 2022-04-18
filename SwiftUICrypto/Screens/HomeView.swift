//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var stateController: StateController
    @State var showPortfolio: Bool = false
    @State var showPortfolioEdit: Bool = false
    @State var search: String = ""
    
    @State var isError = false
    var body: some View {
        ZStack {
            Color.Theme.background
                .ignoresSafeArea()
            VStack {
                Header(showPortfolio: $showPortfolio, showPortfolioEdit: $showPortfolioEdit)
                    .padding(.horizontal)
                
                StatisticRow(stats: stateController.stats, showPortfolio: $showPortfolio)
                    .frame(minHeight: 50)
                    .loading(stateController.isLoading)
                
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
                    CoinList(coins: stateController.portfolioCoins, showPortfolio: true)
                        .transition(.move(edge: .trailing))
                        .task {
                            print("in task")
                            await stateController.fetch()
                            stateController.fetchPortfolioCoins()
                        }
                }
                if !showPortfolio {
                    CoinList(coins: filteredCoins, showPortfolio: false)
                        .transition(.move(edge: .leading))
                        .loading(stateController.isLoading)
                }
            }
        }
        .sheet(isPresented: $showPortfolioEdit, content: {
            Portfolio()
        })
        .alert("Error", isPresented: $isError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("An error happenned, try again later")
        }
        .task {
            if Task.isCancelled { return }
            await stateController.fetch()
        }
    }
    
    var filteredCoins: [Coin] {
        if search.isEmpty {
            return stateController.allCoins
        } else {
            return stateController.allCoins.filter {
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
            .environmentObject(StateController())
        HomeView()
            .environmentObject(StateController())
            .preferredColorScheme(.dark)
    }
}
