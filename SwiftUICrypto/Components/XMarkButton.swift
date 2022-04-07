//
//  XMarkButton.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 06..
//

import SwiftUI

struct XMarkButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.title3.bold())
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton() {}
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
