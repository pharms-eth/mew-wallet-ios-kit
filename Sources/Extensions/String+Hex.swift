//
//  String+Hex.swift
//  MEWwalletKit
//
//  Created by Mikhail Nikanorov on 4/25/19.
//  Copyright © 2019 MyEtherWallet Inc. All rights reserved.
//

import Foundation

private let _nonHexCharacterSet = CharacterSet(charactersIn: "0123456789ABCDEF").inverted

extension String {
  func isHex() -> Bool {
    var rawHex = self
    rawHex.removeHexPrefix()
    rawHex = rawHex.uppercased()
    return (rawHex.rangeOfCharacter(from: _nonHexCharacterSet) == nil)
  }
    
  mutating func removeHexPrefix() {
    if self.hasPrefix("0x") {
      let indexStart = self.index(self.startIndex, offsetBy: 2)
      self = String(self[indexStart...])
    }
  }
  
  mutating func addHexPrefix() {
    if !self.hasPrefix("0x") {
      self = "0x" + self
    }
  }
  
  mutating func alignHexBytes() {
    guard self.isHex(), self.count % 2 != 0 else {
      return
    }
    let hasPrefix = self.hasPrefix("0x")
    if hasPrefix {
      self.removeHexPrefix()
    }
    self = "0" + self
    if hasPrefix {
      self.addHexPrefix()
    }
  }
  
  func hasHexPrefix() -> Bool {
    return self.hasPrefix("0x")
  }
  
  func stringRemoveHexPrefix() -> String {
    var string = self
    string.removeHexPrefix()
    return string
  }
  
  func stringAddHexPrefix() -> String {
    var string = self
    string.addHexPrefix()
    return string
  }
  
  func stringWithAlignedHexBytes() -> String {
    var string = self
    string.alignHexBytes()
    return string
  }
}
