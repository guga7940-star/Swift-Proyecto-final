//
//  WeaponDetailView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 06/12/25.
//


import SwiftUI

struct WeaponDetailView: View {
    let weapon: Weapon
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                // 1. ENCABEZADO Y PRECIO
                VStack(spacing: 5) {
                    Text(weapon.displayName.uppercased())
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundStyle(.white)
                        .tracking(2)
                    
                    if let shop = weapon.shopData {
                        Text("\(shop.categoryText.uppercased()) // $\(shop.cost)")
                            .font(.headline)
                            .foregroundStyle(Color.valRed)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.valRed.opacity(0.1))
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.valRed, lineWidth: 1)
                            )
                    }
                }
                .padding(.top, 40)
                
                // 2. IMAGEN DEL ARMA
                ZStack {
                    // Fondo decorativo (círculo sutil)
                    Circle()
                        .fill(Color.valRed.opacity(0.1))
                        .frame(width: 300, height: 300)
                        .blur(radius: 50)
                    
                    AsyncImage(url: weapon.iconURL) { img in
                        img.resizable()
                            .aspectRatio(contentMode: .fit)
                            .rotationEffect(.degrees(15)) // Un pequeño giro para estilo
                    } placeholder: {
                        ProgressView().tint(Color.valRed)
                    }
                    .frame(height: 180)
                    .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                }
                
                // 3. ESTADÍSTICAS (GRID)
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "chart.bar.fill").foregroundStyle(Color.valRed)
                        Text("ESPECIFICACIONES //")
                            .font(.headline).bold()
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        // Cadencia de Fuego
                        StatBox(title: "CADENCIA", value: String(format: "%.1f /s", weapon.weaponStats?.fireRate ?? 0))
                        
                        // Cargador
                        StatBox(title: "CARGADOR", value: "\(weapon.weaponStats?.magazineSize ?? 0)")
                        
                        // Penetración (Si tuviéramos el dato, por ahora placeholder)
                        StatBox(title: "PENETRACIÓN", value: "MEDIA")
                        
                        // Rango (Placeholder)
                        StatBox(title: "RANGO EFECTIVO", value: "50M")
                    }
                }
                .padding()
            }
        }
        .background(Color.valDark) // Fondo Oscuro
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Sub-componente para las cajitas de estadísticas
struct StatBox: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .bold()
                .foregroundStyle(.gray)
            
            Text(value)
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(4)
        .overlay(
            Rectangle().frame(width: 2).foregroundColor(Color.valRed),
            alignment: .leading
        )
    }
}