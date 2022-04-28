//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct ContentView: View {
    @StateObject var stateController: StateController = StateController()
    @State var exitSplash = false
    var body: some View {
//        ZStack {
            NavigationView {
                HomeView()
                    .environmentObject(stateController)
                    .navigationBarHidden(true)
                    .overlay {
                        if !exitSplash {
                            SplashView(exit: $exitSplash)
                                .transition(.scale)
                        }
                    }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
