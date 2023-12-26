//
//  ItemBuildEntity+CoreDataProperties.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-25.
//
//

import CoreData
import Foundation

public extension ItemBuildEntity {
  @nonobjc
  class func fetchRequest() -> NSFetchRequest<ItemBuildEntity> {
    return NSFetchRequest<ItemBuildEntity>(entityName: "ItemBuildEntity")
  }

  @NSManaged var coreItems: NSObject?
  @NSManaged var earlyGame: NSObject?
  @NSManaged var luxuryItems: NSObject?
  @NSManaged var situationalItems: NSObject?
  @NSManaged var startingItems: NSObject?
}

extension ItemBuildEntity: Identifiable {}
