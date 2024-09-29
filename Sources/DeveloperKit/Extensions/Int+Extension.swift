//
//  Int+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 29/9/24.
//

extension Int {
    public func isBetween(_ min: Int, max: Int) -> Bool {
        return min <= self && self <= max
    }
}
