//
//  Optional+Extension.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 25/11/24.
//

import Foundation

extension Optional {
    public var isNull: Bool {
        return self == nil
    }
    
    public var isNotNull: Bool {
        return !isNull
    }
}
