//
//  MapsListView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//

import SwiftUI

struct MapsListView: View {
    @State private var viewModel = ValorantViewModel()
    
    @State private var searchText = ""
    
    var filteredMaps: [GameMap] {
        if searchText.isEmpty {
            return viewModel.maps
        } else {
            return viewModel.maps.filter { map in
                map.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.valDark.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 3. BARRA DE BÚSQUEDA (Reutilizada)
                    SearchBar(text: $searchText)
                        .padding(.top)
                    
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(Color.valRed)
                                .controlSize(.large)
                                .frame(maxHeight: .infinity)
                        }  else if let error = viewModel.errorMessage {
                            VStack(spacing: 10) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color.valRed)
                                
                                Text("ERROR DE CONEXIÓN")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    
                                Text(error)
                                    .font(.caption)
                                    .foregroundStyle(Color.valRed)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                
                                // 👇 ESTE BOTÓN ES EL QUE PIDE EL REQUISITO
                                Button(action: {
                                    Task {
                                        // En MapsListView usa loadMaps(), en Weapons usa loadWeapons()
                                        await viewModel.loadMaps()
                                    }
                                }) {
                                    Text("REINTENTAR")
                                        .font(.headline)
                                        .bold()
                                        .padding()
                                        .background(Color.white.opacity(0.1))
                                        .foregroundColor(.white)
                                        .cornerRadius(4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color.valRed, lineWidth: 1)
                                        )
                                }
                                .padding(.top)
                            }
                            .frame(maxHeight: .infinity) // Centrar en pantalla
                        } else {
                            ScrollView {
                                LazyVStack(spacing: 20) {
                                    // 4. USAMOS LA LISTA FILTRADA
                                    ForEach(filteredMaps) { map in
                                        NavigationLink(destination: MapDetailView(map: map)) {
                                            VStack(alignment: .leading, spacing: 0) {
                                                AsyncImage(url: map.splashURL) { image in
                                                    image.resizable()
                                                         .aspectRatio(contentMode: .fill)
                                                } placeholder: {
                                                    Color.gray.opacity(0.1)
                                                }
                                                .frame(height: 160)
                                                .clipped()
                                                .overlay(
                                                    LinearGradient(colors: [.clear, .valDark.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                                                )
                                                
                                                HStack {
                                                    Text(map.displayName.uppercased())
                                                        .font(.title2)
                                                        .bold()
                                                        .foregroundStyle(.white)
                                                        .tracking(1)
                                                    
                                                    Spacer()
                                                    
                                                    AsyncImage(url: map.listIconURL) { icon in
                                                        icon.resizable().aspectRatio(contentMode: .fit)
                                                    } placeholder: { EmptyView() }
                                                    .frame(width: 30, height: 30)
                                                }
                                                .padding()
                                                .background(Color.white.opacity(0.05))
                                            }
                                            .cornerRadius(4)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                            )
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.top)
                            }
                        }
                    }
                }
            }
            .navigationTitle("MAPAS")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if viewModel.maps.isEmpty {
                    await viewModel.loadMaps()
                }
            }
        }
    }
}

#Preview {
    MapsListView()
}
