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
            AsyncImage(url: agent.iconURL) { phase in
                if let image = phase.image {
                    image.resizable().aspectRatio(contentMode: .fit)
                } else {
                    Color.gray.opacity(0.1)
                }
            }
            .frame(width: 50, height: 50)
            .background(Color.valDark)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.valRed, lineWidth: 2))
            
            VStack(alignment: .leading) {
                Text(agent.displayName.uppercased())
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.white)
                    .tracking(1)
                
                Text(agent.role?.displayName.uppercased() ?? "AGENTE")
                    .font(.caption)
                    .bold()
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.valRed.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .opacity(0.5)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .overlay(
            Rectangle().frame(width: 4).foregroundColor(Color.valRed),
            alignment: .leading
        )
    }
}
