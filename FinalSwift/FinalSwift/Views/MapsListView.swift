//
//  MapsListView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//

import SwiftUI

struct MapsListView: View {
    @State private var viewModel = ValorantViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 1. FONDO OSCURO GLOBAL
                Color.valDark.ignoresSafeArea()
                
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Color.valRed)
                            .controlSize(.large)
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)").foregroundStyle(Color.valRed)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 20) {
                                ForEach(viewModel.maps) { map in
                                    
                                    // 2. NAVEGACIÓN AL DETALLE
                                    NavigationLink(destination: MapDetailView(map: map)) {
                                        
                                        // 3. DISEÑO DE TARJETA (TÁCTICO)
                                        VStack(alignment: .leading, spacing: 0) {
                                            // Imagen Grande
                                            AsyncImage(url: map.splashURL) { image in
                                                image.resizable()
                                                     .aspectRatio(contentMode: .fill)
                                            } placeholder: {
                                                Color.gray.opacity(0.1)
                                            }
                                            .frame(height: 160)
                                            .clipped()
                                            .overlay(
                                                // Degradado para leer mejor el texto
                                                LinearGradient(colors: [.clear, .valDark.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                                            )
                                            
                                            // Información de abajo
                                            HStack {
                                                Text(map.displayName.uppercased())
                                                    .font(.title2)
                                                    .bold()
                                                    .foregroundStyle(.white) // Texto blanco
                                                    .tracking(1)
                                                
                                                Spacer()
                                                
                                                // Icono del mapa
                                                AsyncImage(url: map.listIconURL) { icon in
                                                    icon.resizable().aspectRatio(contentMode: .fit)
                                                } placeholder: {
                                                    EmptyView()
                                                }
                                                .frame(width: 30, height: 30)
                                            }
                                            .padding()
                                            .background(Color.white.opacity(0.05)) // Fondo semitransparente
                                        }
                                        .cornerRadius(4) // Bordes rectos estilo Valorant
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
