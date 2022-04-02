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

extension Double {
    var percentageFormatted: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .percent
        return formatter.string(from: NSNumber(value: self/100)) ?? "0.00% !"
    }
    
    func currencyFormatted(digits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = digits
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00 !"
    }
    
    func formatted(digits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        return formatter.string(from: NSNumber(value: self)) ?? "0.00 !"
    }
}

// MARK: - Previews
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
        
        VStack {
            Text((-32.6212).percentageFormatted)
        }
        .padding()
        .previewLayout(.sizeThatFits)
        
        VStack {
            Text(44470.532652704656.currencyFormatted(digits: 2))
        }
        .padding()
        .previewLayout(.sizeThatFits)
        
        VStack {
            Text(44228.80588539307.currencyFormatted(digits: 6))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
