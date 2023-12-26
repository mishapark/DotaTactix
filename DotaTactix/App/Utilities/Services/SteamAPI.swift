//
//  SteamAPI.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-18.
//

import Foundation

enum SteamAPI {
  static func newsEndpoint(count: Int) -> String {
    "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=570&count=\(count)&maxlength=300&format=json"
  }
}
