//
//  WeaponsListView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//


import SwiftUI

struct WeaponsListView: View {
    @State private var viewModel = ValorantViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando Arsenal...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundStyle(.red)
                } else {
                    List(viewModel.weapons) { weapon in
                        HStack {
                            // Imagen del arma (Son anchas, así que usamos rectangle)
                            AsyncImage(url: weapon.iconURL) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Color.gray.opacity(0.1)
                            }
                            .frame(width: 100, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text(weapon.displayName)
                                    .font(.headline)
                                    .bold()
                                
                                // Mostrar categoría y precio si existen
                                if let shop = weapon.shopData {
                                    Text("\(shop.categoryText) • $\(shop.cost)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                } else {
                                    Text("Melee / Especial")
                                        .font(.caption)
                                        .foregroundStyle(.orange)
                                }
                            }
                            .padding(.leading, 10)
                        }
                        .padding(.vertical, 5)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Arsenal")
            .task {
                if viewModel.weapons.isEmpty {
                    await viewModel.loadWeapons()
                }
            }
        }
    }
}

#Preview {
    WeaponsListView()
}