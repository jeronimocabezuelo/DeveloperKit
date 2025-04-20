//
//  NullableDatePickerView.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 7/12/24.
//

import SwiftUI

public struct NullableDatePickerView: View {
    public var title: String
    @Binding public var date: Date?
    
    public init(title: String, date: Binding<Date?>) {
        self.title = title
        self._date = date
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            if let date = date {
                // DatePicker visible solo si hay una fecha seleccionada
                DatePicker(
                    "",
                    selection: Binding(
                        get: { date },
                        set: { self.date = $0 }
                    ),
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                
                Button("Eliminar fecha") {
                    self.date = nil
                }
                .foregroundColor(.red)
            } else {
                // Botón para establecer una fecha
                Button("Seleccionar fecha") {
                    self.date = Date() // Usa la fecha actual como predeterminada
                }
                .foregroundColor(.blue)
            }
        }
        .padding()
    }
}
