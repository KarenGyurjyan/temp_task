//
//  DomainConvertable.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation

public protocol DomainConvertible {
  associatedtype DomainModel
  func toDomain() -> DomainModel
}

public extension Array where Element: DomainConvertible {
  func toDomain() -> [Element.DomainModel] {
    map { $0.toDomain() }
  }
}
