//
//  DividedForEach.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 29/9/24.
//

import SwiftUI

public struct DividedForEach<Data: RandomAccessCollection, ID: Hashable, Content: View, D: View>: View {
    let data: Data
    let id: KeyPath<Data.Element, ID>
    let content: (Data.Element) -> Content
    let divider: (Int) -> D
    
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> Content, divider: @escaping () -> D) {
        self.init(
            data,
            id: id,
            content: content,
            divider: { _ in divider() }
        )
    }
    
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> Content, divider: @escaping (Int) -> D) {
        self.data = data
        self.id = id
        self.content = content
        self.divider = divider
    }
    
    public var body: some View {
        ForEach(Array(data.enumerated()), id: \.offset) { index, element in
            content(element)
            
            // Usamos el índice para decidir si mostrar el divisor
            if index != data.count - 1 {
                divider(index)
            }
        }
    }
}
