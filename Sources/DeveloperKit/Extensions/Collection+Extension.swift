//
//  Collection+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 10/5/25.
//

import Foundation

extension Collection {
    public var isNotEmpty: Bool { !isEmpty }
}

extension Collection where Element: Identifiable {
    public func find(id: Element.ID?) -> Element? {
        guard let id else { return nil }
        return first { $0.id == id }
    }
    
    public func findIndex(id: Element.ID?) -> Index? {
        guard let id else { return nil }
        return firstIndex { $0.id == id }
    }
}
