//
//  SelectorView.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 20/4/25.
//

import SwiftUI

public struct SelectorView<Option: Identifiable & Equatable, Label: View, OptionView: View>: View {
    @Binding var selected: Option
    let options: [Option]
    let label: () -> Label
    let optionView: (Option) -> OptionView
    
    public init(
        selected: Binding<Option>,
        options: [Option],
        @ViewBuilder label: @escaping () -> Label = { EmptyView() },
        @ViewBuilder optionView: @escaping (Option) -> OptionView
    ) {
        self._selected = selected
        self.options = options
        self.label = label
        self.optionView = optionView
    }
    
    public var body: some View {
        HStack(spacing: 6) {
            label()
            HStack(spacing: 0) {
                // TODO: Añadir un separador
                ForEach(options) { option in
                    Button {
                        selected = option
                    } label: {
                        optionView(option)
                    }
                    .buttonStyle(.plain)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.secondary.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.secondary.opacity(0.5), lineWidth: 0.5)
            )
        }
    }
}
