//
//  AgentDetailView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//


import SwiftUI

struct AgentDetailView: View {
    let agent: Agent
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: agent.portraitURL) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                } placeholder: {
                    AsyncImage(url: agent.iconURL) { icon in
                        icon.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [.red.opacity(0.3), .black], startPoint: .top, endPoint: .bottom)
                )
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(agent.displayName)
                            .font(.system(size: 40, weight: .heavy))
                        
                        Spacer()
                        
                        if let role = agent.role {
                            Text(role.displayName)
                                .font(.headline)
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8)
                        }
                    }
                    
                    Divider()
                    
                    Text("BIOGRAFÍA")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Text(agent.description)
                        .font(.body)
                    
                    Divider()
                    
                    if let abilities = agent.abilities {
                        Text("HABILIDADES")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .bold()
                        
                        ForEach(abilities, id: \.self) { ability in
                            HStack(alignment: .top) {
                                AsyncImage(url: ability.iconURL) { icon in
                                    icon.resizable().aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "bolt.fill")
                                }
                                .frame(width: 40, height: 40)
                                .padding(5)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading) {
                                    Text(ability.displayName)
                                        .font(.headline)
                                    Text(ability.description)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

