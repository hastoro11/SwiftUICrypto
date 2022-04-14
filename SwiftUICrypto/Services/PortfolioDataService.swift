//
//  PortfolioDataService.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 12..
//

import SwiftUI
import CoreData

class PortfolioDataService: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    // in memory for testing
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "PortfolioModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
//            self.test()
        }
    }
    
    func test() {
//        updatePortfolio(coin: TestData.coin(0), amount: 1.5)
//        print(fetchPortfolio())
//        updatePortfolio(coin: TestData.coin(0), amount: 2)
//        print(fetchPortfolio())
//        updatePortfolio(coin: TestData.coin(1), amount: 1.5)
//        print(fetchPortfolio())
//        updatePortfolio(coin: TestData.coin(2), amount: 2)
//        print(fetchPortfolio())
//        updatePortfolio(coin: TestData.coin(0), amount: 0)
//        updatePortfolio(coin: TestData.coin(1), amount: 0)
//        updatePortfolio(coin: TestData.coin(2), amount: 0)
//        print(fetchPortfolio())
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        let entities = self.fetchPortfolio()
        if let entity = entities.first(where: {$0.coinID == coin.id }) {
            if amount > 0 {
                entity.amount = amount
            } else {
                self.delete(coin: coin)
            }
        } else {
            self.add(coin: coin, amount: amount)
        }
    }
    
    func fetchPortfolio() -> [PortfolioEntity] {
        let request: NSFetchRequest<PortfolioEntity> = NSFetchRequest(entityName: "PortfolioEntity")
        do {
            let entities = try container.viewContext.fetch(request)
            return entities
        } catch {
            print("Error fetching entities: ", error)
            return []
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        save()
    }
    
    private func delete(coin: Coin) {
        let entities = self.fetchPortfolio()
        if let entity = entities.first(where: {$0.coinID == coin.id}) {
            container.viewContext.delete(entity)
            save()
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving core data: ", error)
        }
    }
    
    // sample data
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        for i in 1...5 {
            let entity = PortfolioEntity(context: viewContext)
            entity.coinID = "id-\(i)"
            entity.amount = Double(i)
        }
        
        try viewContext.save()
    }
    
    // for preview
    static var preview: PortfolioDataService = {
        let dataService = PortfolioDataService(inMemory: true)
        let viewContext = dataService.container.viewContext
        
        do {
            try dataService.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return dataService
    }()
}
