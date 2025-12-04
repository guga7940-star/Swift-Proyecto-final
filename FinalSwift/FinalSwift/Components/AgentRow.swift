//
//  AgentRow.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//


import SwiftUI

struct AgentRow: View {
    let agent: Agent // Recibe el dato
    
    var body: some View {
        HStack(spacing: 15) {
            // Imagen con manejo de carga
            AsyncImage(url: agent.iconURL) { phase in
                if let image = phase.image {
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "person.slash.fill")
                        .foregroundStyle(.gray)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50)
            .background(Color.gray.opacity(0.1))
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(agent.displayName)
                    .font(.headline)
                    .bold()
                
                Text(agent.role?.displayName ?? "Sin Rol")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}