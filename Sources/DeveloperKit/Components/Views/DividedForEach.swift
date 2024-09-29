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
    let divider: (() -> D)
    
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> Content, divider: @escaping () -> D) {
        self.data = data
        self.id = id
        self.content = content
        self.divider = divider
    }
    
    public var body: some View {
        ForEach(data, id: id) { element in
            content(element)
            
            if element[keyPath: id] != data.last?[keyPath: id] {
                divider()
            }
        }
    }
}
