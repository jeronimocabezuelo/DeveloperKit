//
//  Sequence+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 29/9/24.
//

import Foundation

extension Sequence where Element: Numeric {
    /// Returns the sum of all elements in the collection
    public func sum() -> Element { return reduce(0, +) }
}
