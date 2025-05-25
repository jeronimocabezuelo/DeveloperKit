//
//  TextView.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 19/4/25.
//

import SwiftUI

public struct TextViewOld: View {
    @Binding var text: String
    var placeholder: String
    
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray.opacity(0.6))
                //                    .padding(.top, 3)
                    .padding(.leading, 4)
            }
            
            TextEditor(text: $text)
                .padding(.vertical, 4)
                .scrollContentBackground(.hidden)
        }
        .font(.body)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}

public struct TextView: View {
    @Binding var text: String
    var placeholder: String
    
    @State private var textHeight: CGFloat = 24
    
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray.opacity(0.6))
                    .padding(.leading, 4)
            }
            
            ZStack(alignment: .leading) {
                TextEditor(text: $text)
                    .frame(height: textHeight)
                    .scrollContentBackground(.hidden)
                
                // Texto invisible para medir altura
                Text(text + " ")
                    .font(.body)
                    .padding(.leading, 5)
                    .foregroundStyle(.clear)
                    .background(
                        GeometryReader { geo in
                            Color.clear.preference(key: TextHeightPreferenceKey.self, value: geo.size.height)
                        }
                    )
                    .onPreferenceChange(TextHeightPreferenceKey.self) { height in
                        var adjustedHeight = height
                        if Platform.current != .mac { adjustedHeight += 17 }
                        if adjustedHeight != textHeight {
                            textHeight = adjustedHeight
                        }
                    }
            }
            .padding(.vertical, 4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        }
        .font(.body)
    }
}

private struct TextHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 24
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper("Esta es \notra línea \notra línea", content: { binding in
            VStack {
                TextField("Escribe algo...", text: binding)
                TextView(text: binding, placeholder: "Escribe algo...")
                    .scrollDisabled(true)
            }
            
        })
    }
}

// Helper para permitir usar @Binding en previews
struct StatefulPreviewWrapper<Value>: View {
    @State private var value: Value
    private var content: (Binding<Value>) -> AnyView
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> some View) {
        _value = State(initialValue: value)
        self.content = { binding in AnyView(content(binding)) }
    }
    
    var body: some View {
        content($value)
    }
}
