//
//  Codable+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 9/5/25.
//

import Foundation

extension Encodable {
    public func encodeToData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
