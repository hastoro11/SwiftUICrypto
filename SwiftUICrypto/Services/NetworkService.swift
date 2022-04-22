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

//class NetworkService {
//    
//    static func getCoins() async throws -> [Coin] {
//        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
//        let data = try await fetchData(urlString: urlString)
//        
//        do {
//            let coins = try JSONDecoder().decode([Coin].self, from: data)
//            return coins
//        } catch {
//            print("[🔥] Decoding error, coins: ", error)
//            throw CoinDataError.decodingError
//        }
//    }
//    
//    static func getMarketData() async throws -> [Statistic] {
//        let urlString = "https://api.coingecko.com/api/v3/global"
//        let data = try await fetchData(urlString: urlString)
//        
//        do {
//            let globalmarketData = try JSONDecoder().decode(GlobaMarketData.self, from: data)
//            let marketData = globalmarketData.data
//            var stats = [Statistic]()
//            let marketCap = Statistic(
//                title: "Market Cap",
//                value: marketData.marketCap.formattedWithAbbreviations(),
//                percentageChange: marketData.marketCapChangePercentage24HUsd)
//            let total24hVolume = Statistic(title: "24h Volume", value: marketData.total24hVolume.formattedWithAbbreviations())
//            let btcDominance = Statistic(title: "BTC Dominance", value: marketData.btcDominance.formattedWithAbbreviations())
//            stats.append(marketCap)
//            stats.append(total24hVolume)
//            stats.append(btcDominance)
//            stats.append(Statistic(title: "Portfolio Volume", value: "$0.00"))
//            return stats
//        } catch {
//            print("[🔥] Decoding error, market data: ", error)
//            throw CoinDataError.decodingError
//        }
//    }
//    
//    private static func fetchData(urlString: String) async throws -> Data {
//        guard let url = URL(string: urlString) else {
//            throw CoinDataError.badURL(urlString)
//        }
//        let (data, response) = try await URLSession.shared.data(from: url)
//        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//            throw CoinDataError.badURLResponse(url)
//        }
//        
//        if data.isEmpty {
//            throw CoinDataError.emptyData(url)
//        }
//        
//        return data
//    }
//}

// MARK: - Protocol NetworkRequest
protocol NetworkRequest {
    associatedtype Model
    var url: URL { get }
    func decode(_ data: Data) -> Model?
}

extension NetworkRequest {    
    func execute() async -> Model?  {
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { return nil }
        return decode(data)
    }
}

struct CoinRequest: NetworkRequest {
    typealias Model = [Coin]
    var url: URL
    init(_ url: URL) {
        self.url = url
    }
        
    func decode(_ data: Data) -> Model? {
        return try? JSONDecoder().decode(Model.self, from: data)
    }
}

struct MarketDataRequest: NetworkRequest {
    var url: URL
    init(_ url: URL) {
        self.url = url
    }
    
    func decode(_ data: Data) -> GlobaMarketData? {
        return try? JSONDecoder().decode(GlobaMarketData.self, from: data)
    }
  
}

struct CoinDetailRequest: NetworkRequest {
    var url: URL
    init(_ id: String) {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        self.url = URL(string: urlString)!
    }
    
    func decode(_ data: Data) -> CoinDetail? {
        return try? JSONDecoder().decode(CoinDetail.self, from: data)
    }
}

