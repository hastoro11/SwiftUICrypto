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
                    HStack(spacing: 2) {
                        Text("Coin")
                        Image(systemName: "triangle.fill")
                            .font(.caption2)
                            .rotationEffect(Angle(degrees: stateController.sortType == .rank ? 0 : 180))
                            .opacity(stateController.sortType == .rank || stateController.sortType == .rankReversed ? 1 : 0)
                    }
                    .onTapGesture {
                        withAnimation {
                            stateController.changeSortType(to: stateController.sortType == .rank ? .rankReversed : .rank)
                        }
                    }
                    Spacer()
                    if showPortfolio {
                        HStack(spacing: 2) {
                            Text("Holdings")
                            Image(systemName: "triangle.fill")
                                .rotationEffect(Angle(degrees: stateController.sortType == .holdings ? 0 : 180))
                                .opacity(stateController.sortType == .holdings || stateController.sortType == .holdingsReversed ? 1 : 0)
                        }
                        .onTapGesture {
                            withAnimation {
                                stateController.changeSortType(to: stateController.sortType == .holdings ? .holdingsReversed : .holdings)
                            }
                        }
                    }
                    HStack(spacing: 2) {
                        Button(action: {
                            Task {
                                await stateController.fetch()
                            }
                        }) {
                            Image(systemName: "arrow.counterclockwise")
                        }
                        Text("Price")
                        Image(systemName: "triangle.fill")
                            .font(.caption2)
                            .rotationEffect(Angle(degrees: stateController.sortType == .price ? 0 : 180))
                            .opacity(stateController.sortType == .price || stateController.sortType == .priceReversed ? 1 : 0)
                    }
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                    .onTapGesture {
                        withAnimation {
                            stateController.changeSortType(to: stateController.sortType == .price ? .priceReversed : .price)
                        }
                    }
                }
                .font(.caption)
                .foregroundColor(Color.Theme.secondaryText)
                .padding(.horizontal)
                
                if showPortfolio {
                    CoinList(coins: stateController.portfolioCoins, showPortfolio: true)
                        .transition(.move(edge: .trailing))
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
    
    func update() async {
        await stateController.fetch()
    }
}



struct Previews_HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(StateController.preview)
        HomeView()
            .environmentObject(StateController.preview)
            .preferredColorScheme(.dark)
    }
}
