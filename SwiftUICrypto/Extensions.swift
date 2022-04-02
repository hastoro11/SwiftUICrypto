//
//  Extensions.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import Foundation
import SwiftUI

extension Color {
    struct Theme {
        static var background: Color {
            Color("BackgroundColor")
        }
        static var green: Color {
            Color("GreenColor")
        }
        static var red: Color {
            Color("RedColor")
        }
        static var secondaryText: Color {
            Color("SecondaryTextColor")
        }
    }
}


struct Previews_Extensions_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .foregroundColor(Color.Theme.red)
            Text("Hello, World!")
                .foregroundColor(Color.Theme.green)
            Text("Hello, World!")
                .foregroundColor(Color.Theme.secondaryText)
            Text("Hello, World!")
                .foregroundColor(.accentColor)
        }
        .padding()
        .background {
            Color.Theme.background
        }
        .previewLayout(.sizeThatFits)
        
        VStack {
            Text("Hello, World!")
                .foregroundColor(Color.Theme.red)
            Text("Hello, World!")
                .foregroundColor(Color.Theme.green)
            Text("Hello, World!")
                .foregroundColor(Color.Theme.secondaryText)
            Text("Hello, World!")
                .foregroundColor(.accentColor)
        }
        .padding()
        .background {
            Color.Theme.background
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
