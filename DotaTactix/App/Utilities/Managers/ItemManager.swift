//
//  ItemManager.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-19.
//

import Foundation

class ItemManager: ObservableObject {
  static let shared = ItemManager()
  private init() {}

  @Published var items: [Item] = []
  @Published var sortedItems: [(String, [Item])] = []

  func fetchItems() async throws {
    let items: [String: Item] = try await DataManager.shared.fetchFromFileOrURL(
      fileName: "items.json",
      url: OpenDotaEndpoints.items.rawValue
    )

    let itemArray: [Item] = items.map { key, item in
      var newItem = item
      newItem.name = key
      return newItem
    }

    self.items = itemArray
    sortedItems = filterSortItems(items: itemArray)
  }

  func refreshItems() async throws {
    let itemsData = try await NetworkManager.shared.fetchFromURL(OpenDotaEndpoints.items.rawValue)
    let items = try JSONDecoder().decode([String: Item].self, from: itemsData)

    let itemArray: [Item] = items.map { key, item in
      var newItem = item
      newItem.name = key
      return newItem
    }

    self.items = itemArray
    sortedItems = filterSortItems(items: itemArray)
  }

  // MARK: - Private methods

  private func filterSortItems(items: [Item]) -> [(String, [Item])] {
    let filteredItems = filterItems(items: items)
    let sortedItems = sortItems(items: filteredItems)
    let sortedByQualityItems = sortItemsByQuality(items: sortedItems)

    return sortedByQualityItems
  }

  private func filterItems(items: [Item]) -> [Item] {
    items.filter {
      $0.dname != nil &&
        !$0.img.contains("recipe")
    }
  }

  private func sortItems(items: [Item]) -> [Item] {
    items.sorted { item1, item2 -> Bool in
      if let cost1 = item1.cost, let cost2 = item2.cost {
        if cost1 != cost2 {
          return cost1 < cost2
        }
      } else if item1.cost == nil, item2.cost != nil {
        return false
      } else if item1.cost != nil, item2.cost == nil {
        return true
      }

      if let name1 = item1.dname, let name2 = item2.dname {
        return name1 < name2
      }
      return false
    }
  }

  private func sortItemsByQuality(items: [Item]) -> [(String, [Item])] {
    let qualities = [
      "Consumable",
      "Common",
      "Component",
      "Rare",
      "Artifact",
      "Epic",
      "Secret Shop",
      "Miscellaneous"
    ]

    let initialResult: [(String, [Item])] = qualities.map { ($0, []) }

    let sortedItems = items.reduce(into: initialResult) { result, item in
      switch item.qual {
      case .consumable:
        result[0].1.append(item)
      case .common:
        result[1].1.append(item)
      case .component:
        result[2].1.append(item)
      case .rare:
        result[3].1.append(item)
      case .artifact:
        result[4].1.append(item)
      case .epic:
        result[5].1.append(item)
      case .secretShop:
        result[6].1.append(item)
      case .none:
        result[7].1.append(item)
      }
    }
    return sortedItems
  }
}
