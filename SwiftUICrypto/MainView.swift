//
//  MainView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct MainView: View {
    @State var showPortfolio: Bool = false
    var body: some View {
        ZStack {
            Color.Theme.background
                .ignoresSafeArea()
            VStack {
                Header(showPortfolio: $showPortfolio)
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        
        MainView()
            .preferredColorScheme(.dark)
    }
}
