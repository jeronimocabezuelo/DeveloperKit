//
//  ForEachFirstLast.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 28/10/24.
//

import SwiftUI

public struct ForEachFirstLast<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let data: Data
    let content: (Data.Element, Bool, Bool) -> Content

    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element, Bool, Bool) -> Content) {
        self.data = data
        self.content = content
    }

    public var body: some View {
        ForEach(Array(data.enumerated()), id: \.1.id) { index, element in
            let isFirst = index == 0
            let isLast = index == data.count - 1
            content(element, isFirst, isLast)
        }
    }
}
