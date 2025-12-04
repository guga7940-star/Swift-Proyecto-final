//
//  AgentsListView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import SwiftUI

struct AgentsListView: View {
    @State private var viewModel = ValorantViewModel()
    
    // 1. Variable para el texto de búsqueda
    @State private var searchText = ""
    
    // 2. Variable computada para filtrar los agentes
    var filteredAgents: [Agent] {
        if searchText.isEmpty {
            return viewModel.agents
        } else {
            return viewModel.agents.filter { agent in
                agent.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack { // Usamos VStack para apilar buscador y lista
                
                // 3. Aquí usamos tu componente reutilizable (RT-1 y RT-5)
                SearchBar(text: $searchText)
                    .padding(.top)
                
                Group {
                    if viewModel.isLoading {
                        ProgressView("Cargando...")
                            .frame(maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage {
                        Text(error).foregroundStyle(.red)
                    } else {
                        // 4. Usamos la lista filtrada
                        List(filteredAgents) { agent in
                            NavigationLink(destination: AgentDetailView(agent: agent)) {
                                AgentRow(agent: agent) // ¡Mucho más limpio!
                            }
                        }
                        .listStyle(.plain)
                    }
                } 
            }
            .navigationTitle("Agentes Valorant")
            .task {
                if viewModel.agents.isEmpty {
                    await viewModel.loadAgents()
                }
            }
        }
    }
}
