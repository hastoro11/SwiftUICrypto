//
//  TestData.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import Foundation

struct TestData {
    static var coins: [Coin] {
        let url = Bundle.main.url(forResource: "testdata", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Coin].self, from: data)
        } catch {
            print("Error in bundle file: ", error)
            return []
        }
    }
    
    static func coin(_ index: Int) -> Coin {
        coins[index]
    }
}
