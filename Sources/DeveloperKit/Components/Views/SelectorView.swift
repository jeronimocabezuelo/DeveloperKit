//
//  SelectorView.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 20/4/25.
//

import SwiftUI

public struct SelectorView<Option: Identifiable & Equatable, Label: View, OptionView: View>: View {
    public enum DividerStyle {
        case hidden
        case nonSelected
        case all
    }
    
    @Binding var selected: Option
    let options: [Option]
    let axis: Axis
    let label: () -> Label
    let optionView: (Option) -> OptionView
    private var dividerStyle: DividerStyle = .all
    
    public init(
        selected: Binding<Option>,
        options: [Option],
        axis: Axis = .vertical,
        @ViewBuilder label: @escaping () -> Label = { EmptyView() },
        @ViewBuilder optionView: @escaping (Option) -> OptionView
    ) {
        self._selected = selected
        self.options = options
        self.axis = axis
        self.label = label
        self.optionView = optionView
    }
    
    @ViewBuilder var content: some View {
        label()
        HStack(spacing: 0) {
            DividedForEach(
                options,
                id: \.id,
                content: { option in
                    Button {
                        selected = option
                    } label: {
                        optionView(option)
                    }
                    .buttonStyle(.plain)
                },
                divider: { index in
                    Rectangle()
                        .fill(Color.secondary.opacity(0.5))
                        .frame(width: 1, height: 16)
                        .opacity(opacityFor(index: index))
                }
            )
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
    
    public var body: some View {
        Stack(axis: axis, alignment: .leading, spacing: 6, content: { content })
    }
    
    func opacityFor(index: Int) -> Double {
        switch dividerStyle {
        case .all:
            return 1
        case .hidden:
            return 0
        case .nonSelected:
            let selectedIndex = options.firstIndex(of: selected)
            let show = selectedIndex != index && selectedIndex != index + 1
            return show ? 1 : 0
        }
    }
    
    public func divider(style: DividerStyle) -> Self {
        var copy = self
        copy.dividerStyle = style
        return copy
    }
}

private struct SelectorOption: Equatable, Identifiable {
    let id: String
    
    static var mock: Self {
        .init(id: "one")
    }
    
    static var options: [Self] {
        [.init(id: "one"), .init(id: "two"), .init(id: "three")]
    }
}

#Preview {
    SelectorView(
        selected: .init(get: { SelectorOption.mock }, set: { _ in}),
        options: SelectorOption.options,
        axis: .vertical,
        label: {
            Text("Hello")
        },
        optionView: {
            Text($0.id)
                .padding()
        }
    )
}
