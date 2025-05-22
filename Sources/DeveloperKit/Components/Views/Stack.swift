//
//  Stack.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 22/5/25.
//

import SwiftUI

public struct Stack<Content: View>: View {
    let axis: Axis
    let spacing: CGFloat?
    let alignment: Alignment?
    let content: () -> Content
    
    public init(axis: Axis,
                spacing: CGFloat? = nil,
                alignment: Alignment? = nil,
                @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }
    
    public var body: some View {
        if axis == .horizontal {
            HStack(
                alignment: verticalAlignment(from: alignment),
                spacing: spacing,
                content: content
            )
        } else {
            VStack(
                alignment: horizontalAlignment(from: alignment),
                spacing: spacing,
                content: content
            )
        }
    }
    
    private func horizontalAlignment(from alignment: Alignment?) -> HorizontalAlignment {
        switch alignment {
        case .leading: return .leading
        case .trailing: return .trailing
        case .center: return .center
        default: return .center
        }
    }
    
    private func verticalAlignment(from alignment: Alignment?) -> VerticalAlignment {
        switch alignment {
        case .top: return .top
        case .bottom: return .bottom
        case .center: return .center
        default: return .center
        }
    }
}

#Preview {
    Stack(axis: .horizontal) {
        Text("Hello World!")
        Text("Goodbye World!")
    }
}
