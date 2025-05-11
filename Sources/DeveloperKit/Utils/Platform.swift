//
//  Platform.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 11/5/25.
//

import SwiftUI

public enum Platform {
    case mac, iPad, iPhone, other
    
    @MainActor
    public static var current: Platform {
#if os(macOS)
        return .mac
#elseif os(iOS)
        switch UIDevice.current.userInterfaceIdiom {
        case .pad: return .iPad
        case .phone: return .iPhone
        default: return .other
        }
#else
        return .other
#endif
    }
}
