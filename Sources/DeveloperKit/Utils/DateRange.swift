//
//  DateRange.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 28/1/25.
//

import Foundation

public struct DateRange: Codable {
    public let start: Date
    public let end: Date
    
    public var plotableValue: String {
        "\(start.formatted(date: .numeric, time: .omitted)) - \(end.formatted(date: .numeric, time: .omitted))"
    }
}

public extension DateRange {
    init?(start: Date?, end: Date?) {
        guard let start, let end else { return nil }
        self.init(start: start, end: end)
    }
}

extension DateRange: Equatable {
    public static func == (lhs: DateRange, rhs: DateRange) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}
