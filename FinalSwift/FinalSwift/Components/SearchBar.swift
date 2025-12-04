//
//  SearchBar.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//

import SwiftUI

struct SearchBar: View {
    // RT-1: @Binding nos permite modificar una variable que vive en la vista padre
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("Buscar agente...", text: $text)
                .textFieldStyle(.plain)
            
            // Botón para borrar texto
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    // Ejemplo de cómo se usa con una variable constante
    SearchBar(text: .constant(""))
}
