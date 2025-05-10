//
//  Dictionary+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 10/5/25.
//

import Foundation

public extension Dictionary {
    func map<NewKey: Hashable, NewValue>(
        key transformKey: (Key) -> NewKey,
        value transformValue: (Value) -> NewValue
    ) -> [NewKey: NewValue] {
        let transformed = self.map { (transformKey($0.key), transformValue($0.value)) }
        return [NewKey: NewValue](uniqueKeysWithValues: transformed)
    }
}
