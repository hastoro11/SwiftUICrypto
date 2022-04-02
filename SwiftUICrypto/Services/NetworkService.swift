//
//  NetworkService.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 02..
//

import SwiftUI

enum CoinDataError: LocalizedError {
    case badURL(String)
    case badURLResponse(URL)
    case emptyData(URL)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .badURL(let string):
            return "[⚡️] Bad URL, " + string
        case .badURLResponse(let uRL):
            return "[⛔️] Bad URL response, \(uRL)"
        case .emptyData(let uRL):
            return "[🗑] Empty data from \(uRL)"
        case .decodingError:
            return "Decoding error"
        }
    }
}

class NetworkService {
    
    static func getCoins() async throws -> [Coin] {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        guard let url = URL(string: urlString) else {
            throw CoinDataError.badURL(urlString)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            throw CoinDataError.badURLResponse(url)
        }
        
        if data.isEmpty {
            throw CoinDataError.emptyData(url)
        }
        
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return coins
        } catch {
            print("[🔥] Decoding error,", error)
            throw CoinDataError.decodingError
        }
    }
}
