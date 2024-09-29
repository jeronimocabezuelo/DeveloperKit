//
//  Float+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 29/9/24.
//

import Foundation

extension Float {
    public func toDecimalString(maxDecimals: Int = 2, minDecimals: Int = 0) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minDecimals
        formatter.maximumFractionDigits = maxDecimals
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
