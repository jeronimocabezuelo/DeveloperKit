//
//  View+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 17/5/25.
//

import SwiftUI

public extension View {
    func customBorderedStyle() -> some View {
#if os(macOS)
        self.buttonStyle(.bordered)
#else
        self.buttonStyle(.borderedProminent)
#endif
    }
}
