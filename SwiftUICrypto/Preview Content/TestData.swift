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
    
    static var stats = [ stat1, stat2, stat3, stat4]
    
    static var stat1 = Statistic(title: "Market Cap", value: "$2.5Tr", percentageChange: -10.27)
    static var stat2 = Statistic(title: "24h Volume", value: "$317.72Bn")
    static var stat3 = Statistic(title: "BTC Dominance", value: "43.37%")
    static var stat4 = Statistic(title: "Value", value: "$123.34k", percentageChange: 6.34)
}
