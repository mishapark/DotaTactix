//
//  StrategyEntity+CoreDataProperties.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-25.
//
//

import CoreData
import Foundation

public extension StrategyEntity {
  @nonobjc
  class func fetchRequest() -> NSFetchRequest<StrategyEntity> {
    return NSFetchRequest<StrategyEntity>(entityName: "StrategyEntity")
  }

  @NSManaged var earlyGame: String?
  @NSManaged var lateGame: String?
  @NSManaged var midGame: String?
}

extension StrategyEntity: Identifiable {}
