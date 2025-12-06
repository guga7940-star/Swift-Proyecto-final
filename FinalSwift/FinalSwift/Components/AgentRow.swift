//
//  AgentRow.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//

import SwiftUI

struct AgentRow: View {
    let agent: Agent
    
    var body: some View {
        HStack(spacing: 15) {
            // FOTO CON BORDE ROJO
            AsyncImage(url: agent.iconURL) { phase in
                if let image = phase.image {
                    image.resizable().aspectRatio(contentMode: .fit)
                } else {
                    Color.gray.opacity(0.1)
                }
            }
            .frame(width: 50, height: 50)
            .background(Color.valDark) // Fondo oscuro detrás de la foto
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.valRed, lineWidth: 2)) // El borde rojo
            
            // TEXTOS ESTILIZADOS
            VStack(alignment: .leading) {
                Text(agent.displayName.uppercased()) // Nombre en mayúsculas
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.white)
                    .tracking(1) // Espaciado entre letras estilo militar
                
                Text(agent.role?.displayName.uppercased() ?? "AGENTE")
                    .font(.caption)
                    .bold()
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.valRed.opacity(0.8)) // Etiqueta roja de fondo
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            Spacer()
            
            // FLECHA A LA DERECHA
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .opacity(0.5)
        }
        .padding()
        // TARJETA DE FONDO
        .background(Color.white.opacity(0.05))
        .overlay(
            // Pequeña línea roja decorativa a la izquierda
            Rectangle().frame(width: 4).foregroundColor(Color.valRed),
            alignment: .leading
        )
    }
}
