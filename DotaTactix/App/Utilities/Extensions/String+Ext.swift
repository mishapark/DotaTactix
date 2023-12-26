//
//  String+Ext.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import Foundation

extension String {
  var stripHTML: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
  }
}
