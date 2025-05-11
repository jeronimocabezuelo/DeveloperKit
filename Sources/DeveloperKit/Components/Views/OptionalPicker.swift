//
//  OptionalPicker.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 11/5/25.
//

import SwiftUI

public struct OptionalPicker<T: Hashable, Content: View, Placeholder: View>: View {
    @Binding var selection: T?
    let placeholder: () -> Placeholder
    let content: () -> Content
    
    public init(selection: Binding<T?>, placeholder: @escaping () -> Placeholder, content: @escaping () -> Content) {
        self._selection = selection
        self.placeholder = placeholder
        self.content = content
    }
    
    public init(selection: Binding<T?>, placeholder: String, content: @escaping () -> Content) where Placeholder == Text {
        self._selection = selection
        self.placeholder = { Text(placeholder) }
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if selection == nil {
                placeholder()
                    .padding(.leading, 4)
            }
            
            Picker("", selection: $selection, content: content)
            .labelsHidden()
        }
    }
}
