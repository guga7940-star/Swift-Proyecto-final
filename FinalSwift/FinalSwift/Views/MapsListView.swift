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
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando Escenarios...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundStyle(.red)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.maps) { map in
                                // Tarjeta de Mapa
                                VStack(alignment: .leading) {
                                    // Imagen Grande (Splash)
                                    AsyncImage(url: map.splashURL) { image in
                                        image.resizable()
                                             .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .frame(height: 180)
                                    .clipped()
                                    
                                    HStack {
                                        Text(map.displayName)
                                            .font(.title2)
                                            .bold()
                                        Spacer()
                                        AsyncImage(url: map.iconURL) { icon in
                                            icon.resizable().aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            EmptyView()
                                        }
                                        .frame(width: 30, height: 30)
                                    }
                                    .padding()
                                }
                                .background(Color.white) // O Color(.systemBackground) para modo oscuro
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Mapas")
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
