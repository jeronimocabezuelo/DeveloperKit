//
//  CenterHStack.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 8/11/24.
//

import SwiftUI

public struct CenterHStack<Leading: View, Center: View, Trailing: View>: View {
    var leading: () -> Leading
    var center: () -> Center
    var trailing: () -> Trailing
    
    public init(
        @ViewBuilder leading: @escaping () -> Leading = {
            Text("").hidden()
        },
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder trailing: @escaping () -> Trailing = {
            Text("").hidden()
        }
    ) {
        self.leading = leading
        self.center = center
        self.trailing = trailing
    }
    
    public var body: some View {
        HStack {
            HStack {
                leading()
                    .fixedSize()
                Spacer(minLength: .zero)
            }
            center()
                .layoutPriority(1)
            HStack {
                Spacer(minLength: .zero)
                trailing()
                    .fixedSize()
            }
        }
    }
}

#Preview {
    CenterHStack(
        leading: {
            Text("leading")
        }, center: {
            Text("Center")
        }
    )
}
