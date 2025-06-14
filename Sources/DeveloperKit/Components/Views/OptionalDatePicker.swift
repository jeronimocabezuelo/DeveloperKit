//
//  OptionalDatePicker.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 10/5/25.
//

import SwiftUI

public struct OptionalDatePicker: View {
    let label: LocalizedStringKey
    @Binding var date: Date?
    let displayedComponents: DatePickerComponents
    
    public init(label: LocalizedStringKey, date: Binding<Date?>, displayedComponents: DatePickerComponents = [.hourAndMinute, .date]) {
        self.label = label
        self._date = date
        self.displayedComponents = displayedComponents
    }
    
    public var body: some View {
        HStack {
            Text(label)
            Spacer()
            
            if let unwrappedDate = date {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { unwrappedDate },
                        set: { date = $0 }
                    ),
                    displayedComponents: displayedComponents
                )
                .labelsHidden()
                
                Button {
                    date = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
                .buttonStyle(.plain)
            } else {
                Button {
                    date = Date()
                } label: {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    @Previewable @State var date: Date?
    
    OptionalDatePicker(
        label: "Label",
        date: $date
    )
}
