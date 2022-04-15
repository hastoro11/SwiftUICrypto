//
//  View+Extension.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 15..
//

import SwiftUI

struct Loading: ViewModifier {
    var isLoading: Bool
    func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: isLoading ? .placeholder : [])
                .overlay(ProgressView("Search..."))
        } else {
            content
        }
    }
}

extension View {
    func loading(_ isLoading: Bool) -> some View {
        self.modifier(Loading(isLoading: isLoading))
    }
}
