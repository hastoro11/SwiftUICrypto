//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    var body: some View {
        HomeView()
            .environmentObject(homeVM)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
