//
//  RippleEffect.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct RippleEffect: View {
    @Binding var animate: Bool
    var body: some View {
        VStack {            
            Circle()
                .stroke(Color.accentColor, lineWidth: 5)
                .scaleEffect(animate ? 1.2 : 0.7)
                .opacity(animate ? 0 : 1)
                .animation(animate ? .easeInOut : nil, value: animate)
        }
    }
}

struct RippleEffect_Previews: PreviewProvider {
    static var previews: some View {
        RippleEffect(animate: .constant(false))
    }
}
