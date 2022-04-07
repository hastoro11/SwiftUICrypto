//
//  Header.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct Header: View {
    @Binding var showPortfolio: Bool
    @Binding var showPortfolioEdit: Bool
    var body: some View {
        ZStack {
            HStack {
                CircleButton(icon: showPortfolio ? "plus" : "info", action: {
                    if showPortfolio {
                        showPortfolioEdit.toggle()
                    }
                })
                    .animation(.none, value: showPortfolio)                    
                    .background {
                        RippleEffect(animate: $showPortfolio)
                    }
                Spacer()
            }
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline.weight(.black))
                .animation(.none, value: showPortfolio)
            
            HStack {
                Spacer()
                CircleButton(icon: "chevron.right", action: {
                    withAnimation {
                        showPortfolio.toggle()
                    }
                })
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(showPortfolio: .constant(false), showPortfolioEdit: .constant(false))
            .padding()
            .previewLayout(.sizeThatFits)
        
        Header(showPortfolio: .constant(false), showPortfolioEdit: .constant(false))
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
