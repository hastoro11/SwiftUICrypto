//
//  CircleButton.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

struct CircleButton: View {
    var icon: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 45, height: 45)
                .background {
                    Circle().fill(Color.Theme.background)
                }
        }
        .foregroundColor(.accentColor)
        .shadow(color: Color.accentColor.opacity(0.3), radius: 10, x: 0, y: 0)
        .padding(5)
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var icon = "plus"
    static var previews: some View {
        CircleButton(icon: icon) {}
            .padding()
            .previewLayout(.sizeThatFits)
        
        CircleButton(icon: icon) {}
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
