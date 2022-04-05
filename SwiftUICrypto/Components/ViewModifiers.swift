//
//  ViewModifiers.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 05..
//

import SwiftUI

struct ShowProgress: ViewModifier {
    @Binding var isLoading: Bool
    func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .overlay {
                    Color.Theme.background.opacity(0.3)
                    ProgressView()
                }
        } else {
            content
        }
    }
}

extension View {
    func showProgress(_ value: Binding<Bool>) -> some View {
        self.modifier(ShowProgress(isLoading: value))
    }
}

struct ShowProgress_Preview: PreviewProvider {
    static var previews: some View {
        Group {
        Text("OK")
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(Color.Theme.red)
            .showProgress(.constant(true))
        
        Text("OK")
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(Color.Theme.red)
            .showProgress(.constant(false))
        }
        .previewLayout(.sizeThatFits)
    }
}
