//
//  AgentsListView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import SwiftUI

struct AgentsListView: View {
    @State private var viewModel = ValorantViewModel()
    @State private var searchText = ""
    
    var filteredAgents: [Agent] {
        if searchText.isEmpty { return viewModel.agents }
        else { return viewModel.agents.filter { $0.displayName.lowercased().contains(searchText.lowercased()) } }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.valDark.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundStyle(.gray)
                        TextField("", text: $searchText, prompt: Text("BUSCAR AGENTE...").foregroundColor(.gray))
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .overlay(Rectangle().stroke(Color.valRed, lineWidth: 1)) // Aquí usamos Color.valRed
                    .padding()
                    
                    if viewModel.isLoading {
                        ProgressView().tint(Color.valRed).frame(maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage {
                        Text(error).foregroundStyle(Color.valRed)
                    } else {
                        List(filteredAgents) { agent in
                            ZStack {
                                NavigationLink(destination: AgentDetailView(agent: agent)) {
                                    EmptyView()
                                }.opacity(0)
                                
                                AgentRow(agent: agent)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("AGENTES")
            .navigationBarTitleDisplayMode(.inline)
            .task { if viewModel.agents.isEmpty { await viewModel.loadAgents() } }
        }
    }
}
