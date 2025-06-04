//
//  ID.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 4/6/25.
//

import Foundation

public struct ID<T>: Hashable { // swiftlint:disable:this type_name
    public let value: UUID
    
    public init() {
        self.value = UUID()
    }
    
    public init(_ value: UUID) {
        self.value = value
    }
    
    public init?(_ value: UUID?) {
        guard let value else { return nil }
        self.value = value
    }
}
