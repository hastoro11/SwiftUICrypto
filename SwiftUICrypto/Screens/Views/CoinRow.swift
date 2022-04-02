//
//  CoinRow.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct CoinRow: View {
    var coin: Coin
    var showCurrentHoldings: Bool
    var body: some View {
        HStack {
            Text("\(coin.rank)")
                .frame(minWidth: 30)
                .font(.caption)
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "bitcoinsign.circle.fill")
                    .font(.system(size: 30))
            }
            .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
            Spacer()
            if showCurrentHoldings {
                VStack(alignment: .trailing) {
                    Text("\(coin.currentHoldingsValue.currencyFormatted(digits: 2))")
                        .bold()
                        .foregroundColor(.accentColor)
                    Text("\((coin.currentHoldings ?? 0).formatted(digits: 2))")
                }
            }
            VStack(alignment: .trailing) {
                Text("\(coin.currentPrice.currencyFormatted(digits: 6))")
                    .bold()
                    .foregroundColor(.accentColor)
                Text("\((coin.priceChangePercentage24H ?? 0).percentageFormatted)")
                    .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.Theme.green : Color.Theme.red)
            }
            .frame(minWidth: UIScreen.main.bounds.width/3.5, alignment: .trailing)
        }
        .font(.subheadline)        
    }
}


struct CoinRow_Preview: PreviewProvider {
    static var coin = TestData.coin(0)
    static var previews: some View {
        CoinRow(coin: coin, showCurrentHoldings: false)
            .padding()
            .previewLayout(.sizeThatFits)
        
        CoinRow(coin: TestData.coin(13), showCurrentHoldings: true)
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
