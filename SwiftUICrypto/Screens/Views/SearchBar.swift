//
//  SearchBar.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 04..
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState var inSearch
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .padding()
            TextField("Search ...", text: $text)
                .disableAutocorrection(true)
                .padding()
                .font(.headline)
                .focused($inSearch)
                .overlay {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .padding()
                    }
                    .opacity(text.isEmpty ? 0 : 1)
                    .onTapGesture {
                        text = ""
                        inSearch = false
                    }
                }
                
        }
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.Theme.background)
                .shadow(color: Color.accentColor.opacity(0.3), radius: 10, x: 0, y: 0)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBar(text: .constant(""), inSearch: .init())
                
            SearchBar(text: .constant(""))
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
