//
//  TextView.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 19/4/25.
//

import SwiftUI

public struct TextView: View {
    @Binding var text: String
    var placeholder: String
    
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.top, 3)
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
