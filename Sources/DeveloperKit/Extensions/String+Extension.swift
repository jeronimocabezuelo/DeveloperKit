//
//  String+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 29/9/24.
//

import Foundation

extension String {
    public enum CustomDateFormat: String {
        case presentationDateFormat = "dd/MM/yyyy"
    }
    
    public func createDate(dateFormat: CustomDateFormat = .presentationDateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        
        return dateFormatter.date(from: self)
    }
}
