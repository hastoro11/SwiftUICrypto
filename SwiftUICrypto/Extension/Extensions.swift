//
//  Extensions.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import Foundation
import SwiftUI

// MARK: - String
extension String {
    var htmlString: NSAttributedString? {
        guard let htmlData = self.data(using: .unicode) else { return nil }
        let options = [
            NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html]
        return try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
    }
    
    var plainHtmlString: String {
        return htmlString?.string ?? ""
    }
    
    var html: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

// MARK: - Date
extension Date {
    static func shortFormatted(_ date: String, addedDays: Double = 0) -> String {
        let isoFormatter = ISO8601DateFormatter()
        var date = isoFormatter.date(from: date) ?? Date()
        date = date.addingTimeInterval(addedDays * 24 * 60 * 60)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// MARK: - Color
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

// MARK: - Double
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
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
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
