//
//  TacticsEntity+CoreDataProperties.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-25.
//
//

import CoreData
import Foundation

public extension TacticsEntity {
  @nonobjc
  class func fetchRequest() -> NSFetchRequest<TacticsEntity> {
    return NSFetchRequest<TacticsEntity>(entityName: "TacticsEntity")
  }

  @NSManaged var id: UUID?
  @NSManaged var date: Date?
  @NSManaged var heroName: String?
  @NSManaged var heroIcon: String?
  @NSManaged var itemBuild: ItemBuildEntity?
  @NSManaged var strategy: StrategyEntity?
}

extension TacticsEntity: Identifiable {}
