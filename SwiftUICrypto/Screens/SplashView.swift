//
//  SplashView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 28..
//

import SwiftUI

struct SplashView: View {
    var message = "Almost ready...".map { String($0)}
    @State var count = 0
    var timer = Timer.publish(every: 0.2, on: .main, in: .default).autoconnect()
    @State var loopCount = 0
    @Binding var exit: Bool
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .overlay {
                    Image("logo-transparent")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            
            HStack(spacing: 0) {
                ForEach(message.indices, id:\.self) { index in
                    Text(message[index])
                        .offset(y: count == index ? -5 : 0)
                }
                .foregroundColor(Color("LaunchAccentColor"))
                .font(.headline.weight(.black))
                .offset(y: 70)
            }
        }
        .onReceive(timer) { t in
            withAnimation {
                count = (count + 1) % message.count
            }
            if count == message.count - 1 {
                loopCount += 1
            }
            
            if loopCount > 0 {
                withAnimation {
                    exit = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(exit: .constant(false))
    }
}
