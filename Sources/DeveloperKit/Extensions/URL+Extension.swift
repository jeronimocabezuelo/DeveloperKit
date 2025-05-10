//
//  URL+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 10/5/25.
//

import Foundation

public extension URL {
    init?(string: String?) {
        guard let string else { return nil }
        self.init(string: string)
    }
}
