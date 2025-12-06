//
//  WeaponsListView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//

import SwiftUI

struct WeaponsListView: View {
    @State private var viewModel = ValorantViewModel()
    
    // 1. ESTADO DEL BUSCADOR
    @State private var searchText = ""
    
    // 2. LÓGICA DE FILTRADO
    var filteredWeapons: [Weapon] {
        if searchText.isEmpty {
            return viewModel.weapons
        } else {
            return viewModel.weapons.filter { weapon in
                weapon.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.valDark.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 3. BARRA DE BÚSQUEDA
                    SearchBar(text: $searchText)
                        .padding(.top)
                    
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(Color.valRed)
                                .controlSize(.large)
                                .frame(maxHeight: .infinity)
                        } else if let error = viewModel.errorMessage {
                            Text("Error: \(error)").foregroundStyle(Color.valRed)
                        } else {
                            // 4. USAMOS LA LISTA FILTRADA
                            List(filteredWeapons) { weapon in
                                ZStack {
                                    NavigationLink(destination: WeaponDetailView(weapon: weapon)) {
                                        EmptyView()
                                    }.opacity(0)
                                    
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

// El componente WeaponRow se queda igual (puedes dejarlo aquí abajo o moverlo a Components)
struct WeaponRow: View {
    let weapon: Weapon
    
    var body: some View {
        HStack(spacing: 15) {
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
