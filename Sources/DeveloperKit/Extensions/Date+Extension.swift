//
//  Date+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 29/9/24.
//

import Foundation

public enum DateFormatterTemplate: String {
    case weekDayMonth = "EEEEddMMMM"
    case time = "HHmm"
}

extension Date {
    public func byAdding(_ component: Calendar.Component,
                         value: Int,
                         calendar: Calendar = .current) -> Date {
        return calendar.date(
            byAdding: component,
            value: value,
            to: self
        ) ?? self
    }
    
    public var today: Date? {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: self)
        
        guard let noon = calendar.date(byAdding: .hour, value: 12, to: startOfDay) else { return nil }
        // Si la hora actual es después de las 12:00 PM, devolver el inicio del siguiente día
        if self > noon {
            return calendar.date(byAdding: .day, value: 1, to: startOfDay)
        } else {
            return startOfDay
        }
    }
    
    public func isBetween(_ startDate: Date?, _ endDate: Date?) -> Bool {
        return (startDate ?? .distantPast) < self && self < (endDate ?? .distantFuture)
    }
    
    public init?(_ stringDate: String?, dateFormat: String = "dd/MM/yyyy HH:mm") {
        guard let stringDate else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        guard let date = formatter.date(from: stringDate) else { return nil }
        self = date
        
    }
    
    public func stringFormatted(dateFormat: String = "dd/MM/yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: self)
    }
    
    public func stringTemplated(_ template: DateFormatterTemplate) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate(template.rawValue)
        
        return formatter.string(from: self)
    }
}

extension TimeInterval {
    public var hoursMinutes: String {
        let hours = Int(self / 3600)
        let minutes = Int(self.truncatingRemainder(dividingBy: 3600) / 60)
        
        return String(format: "%02dH %02dm", hours, minutes)
    }
}
