//
//  ID.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 4/6/25.
//

import Foundation

struct ID<T>: Hashable { // swiftlint:disable:this type_name
    let value: UUID
    
    init() {
        self.value = UUID()
    }
    
    init(_ value: UUID) {
        self.value = value
    }
    
    init?(_ value: UUID?) {
        guard let value else { return nil }
        self.value = value
    }
}
