//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct ContentView: View {
    @StateObject var stateController: StateController = StateController()
    var body: some View {
        NavigationView {
            HomeView()
                .environmentObject(stateController)
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
