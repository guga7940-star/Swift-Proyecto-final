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
            ZStack {
                // 1. FONDO OSCURO
                Color.valDark.ignoresSafeArea()
                
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Color.valRed)
                            .controlSize(.large)
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)").foregroundStyle(Color.valRed)
                    } else {
                        // 2. LISTA ESTILIZADA
                        List(viewModel.weapons) { weapon in
                            ZStack {
                                // Enlace de Navegación Invisible
                                NavigationLink(destination: WeaponDetailView(weapon: weapon)) {
                                    EmptyView()
                                }.opacity(0)
                                
                                // Diseño de la Fila
                                WeaponRow(weapon: weapon)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("ARSENAL")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if viewModel.weapons.isEmpty {
                    await viewModel.loadWeapons()
                }
            }
        }
    }
}

// 3. COMPONENTE DE FILA (LOCAL PARA MANTENER ORDEN)
struct WeaponRow: View {
    let weapon: Weapon
    
    var body: some View {
        HStack(spacing: 15) {
            // Imagen del arma
            AsyncImage(url: weapon.iconURL) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 120, height: 60)
            .background(Color.black.opacity(0.3))
            .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(weapon.displayName.uppercased())
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.white)
                    .tracking(1)
                
                if let shop = weapon.shopData {
                    Text("$\(shop.cost)")
                        .font(.subheadline)
                        .foregroundStyle(Color.valRed)
                        .bold()
                } else {
                    Text("ESPECIAL")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray.opacity(0.5))
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    WeaponsListView()
}
