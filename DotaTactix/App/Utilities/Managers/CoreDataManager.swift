//
//  DataManager.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-25.
//

import CoreData
import Foundation

class CoreDataManager: NSObject, ObservableObject {
  static let shared = CoreDataManager()
  let container: NSPersistentContainer

  override init() {
    container = NSPersistentContainer(name: "Main")

    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Error: \(error.localizedDescription)")
      }
    }
  }

  func getTactics() -> [TacticsArchivedModel] {
    let request: NSFetchRequest<TacticsEntity> = TacticsEntity.fetchRequest()

    do {
      let entities = try container.viewContext.fetch(request)

      return entities.compactMap { entity in
        if let itemBuild = entity.itemBuild,
           let strategy = entity.strategy,
           let id = entity.id,
           let date = entity.date,
           let heroName = entity.heroName,
           let heroIcon = entity.heroIcon
        {
          let strategy = Strategy(
            earlyGame: strategy.earlyGame ?? "",
            midGame: strategy.midGame ?? "",
            lateGame: strategy.lateGame ?? ""
          )
          let itemBuild = ItemBuild(
            startingItems: itemBuild.startingItems as! [String],
            earlyGame: itemBuild.earlyGame as! [String],
            coreItems: itemBuild.coreItems as! [String],
            luxuryItems: itemBuild.luxuryItems as! [String],
            situationalItems: itemBuild.situationalItems as! [String]
          )

          return TacticsArchivedModel(
            id: id,
            itemBuild: itemBuild,
            strategy: strategy,
            date: date,
            heroName: heroName,
            heroIcon: heroIcon
          )
        }
        return nil
      }
    } catch {
      return []
    }
  }

  func saveTactics(itemBuild: ItemBuild, strategy: Strategy, heroName: String, heroIcon: String) {
    let tactics = TacticsEntity(context: container.viewContext)
    tactics.id = UUID()
    tactics.date = Date()
    tactics.heroName = heroName
    tactics.heroIcon = heroIcon
    tactics.itemBuild = createItemBuildEntity(from: itemBuild, context: container.viewContext)
    tactics.strategy = createStrategyEntity(from: strategy, context: container.viewContext)

    do {
      try container.viewContext.save()
      print("Tactics saved!")
    } catch {
      print("Whoops \(error.localizedDescription)")
    }
  }

  func createItemBuildEntity(from itemBuild: ItemBuild, context: NSManagedObjectContext) -> ItemBuildEntity {
    let itemBuildEntity = ItemBuildEntity(context: context)

    itemBuildEntity.startingItems = itemBuild.startingItems as NSObject
    itemBuildEntity.earlyGame = itemBuild.earlyGame as NSObject
    itemBuildEntity.coreItems = itemBuild.coreItems as NSObject
    itemBuildEntity.luxuryItems = itemBuild.luxuryItems as NSObject
    itemBuildEntity.situationalItems = itemBuild.situationalItems as NSObject

    return itemBuildEntity
  }

  func createStrategyEntity(from strategy: Strategy, context: NSManagedObjectContext) -> StrategyEntity {
    let strategyEntity = StrategyEntity(context: context)

    strategyEntity.earlyGame = strategy.earlyGame
    strategyEntity.midGame = strategy.midGame
    strategyEntity.lateGame = strategy.lateGame

    return strategyEntity
  }
}

struct TacticsArchivedModel: Identifiable {
  let id: UUID
  let itemBuild: ItemBuild
  let strategy: Strategy
  let date: Date
  let heroName: String
  let heroIcon: String
}
