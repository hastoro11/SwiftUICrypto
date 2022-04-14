//
//  Portfolio.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 06..
//

import SwiftUI

struct Portfolio: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var search: String = ""
    @State var selectedCoin: Coin?
    @State var quantityOfHoldingString: String = ""
    @State var saved: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(text: $search)
                    .padding()
                
                CoinScroll(coins: filterCoins(), selectedCoin: $selectedCoin, quantityOfHoldingString: $quantityOfHoldingString)
                    .frame(minHeight: 75)
                    .showProgress($homeVM.isCoinDataLoading)
                if selectedCoin != nil {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Current price of \(selectedCoin!.symbol.uppercased()):")
                            Spacer()
                            Text(selectedCoin!.currentPrice.currencyFormatted(digits: 6))
                        }
                        Divider()
                        HStack {
                            Text("Amount holding: ")
                            Spacer()
                            TextField("e. g. 1.234", text: $quantityOfHoldingString)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        Divider()
                        HStack {
                            Text("Current value:")
                            Spacer()
                            Text(calculateCurrentValue(price:selectedCoin!.currentPrice).currencyFormatted(digits: 6))
                        }
                    }
                    .padding()
                    .font(.headline)
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(action: {dismiss()})
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    HStack(spacing: 0) {
                        Image(systemName: "checkmark")
                            .font(.headline)
                            .opacity(saved ? 1 : 0)
                        Button(action: save) {
                            Text("SAVE")
                        }
                        .disabled(
                            quantityOfHoldingString.isEmpty
                        )
                    }
                    .font(.title3.bold())
                }
                
            }
            
        }
        .task {
            await homeVM.fetchCoins()
        }
        
    }
    
    func save() {
        saved = true
        search = ""
        guard let amount = Double(quantityOfHoldingString),
        let coin = selectedCoin else {
            dismiss()
            return
        }
        homeVM.update(coin: coin, amount: amount)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            saved = false
            dismiss()
        }
    }
    
    func filterCoins() -> [Coin] {
        if search.isEmpty {
            return homeVM.allCoins
        } else {
            return homeVM.allCoins.filter { coin in
                coin.symbol.lowercased().contains(search.lowercased()) ||
                coin.name.lowercased().contains(search.lowercased())
            }
        }
    }
    
    func calculateCurrentValue(price: Double) -> Double {
        guard let quantity = Double(quantityOfHoldingString) else {
            return 0.0
        }
        return quantity * price
    }
}

extension Portfolio {
    struct CoinScroll: View {
        @EnvironmentObject var homeVM: HomeViewModel
        var coins: [Coin]
        @Binding var selectedCoin: Coin?
        @Binding var quantityOfHoldingString: String
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(coins) { coin in
                        Portfolio.PortfolioCoin(coin: coin, selected: selectedCoin?.id == coin.id)
                            .onTapGesture {
                                selectedCoin = coin
                                quantityOfHoldingString = String(homeVM.fetchAmountFor(coin))
                            }
                    }
                }
            }
        }
    }
}

extension Portfolio {
    struct PortfolioCoin: View {
        var coin: Coin
        var selected: Bool
        var body: some View {
            VStack {
                AsyncImage(url: URL(string: coin.image)) { image in
                    image.resizable()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .font(.largeTitle)
                }
                .frame(width: 50, height: 50)
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .lineLimit(1)
                Text(coin.name)
                    .font(.caption)
                    .foregroundColor(Color.Theme.secondaryText)
                    .lineLimit(2)
            }
            .padding()
            .overlay {
                if selected {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.Theme.green, lineWidth: 1)
                }
            }
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio()
            .environmentObject(HomeViewModel())
        
        Group {
            Portfolio.PortfolioCoin(coin: TestData.coin(0), selected: false)
                
            
            Portfolio.PortfolioCoin(coin: TestData.coin(0), selected: true)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
