//
//  MapDetailView.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 06/12/25.
//

import SwiftUI

struct MapDetailView: View {
    let map: GameMap
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: map.splashURL) { img in
                        img.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.valDark // CORRECCIÓN: Color.valDark
                    }
                    .frame(height: 250)
                    .clipped()
                    .overlay(Color.black.opacity(0.3))
                    
                    VStack(alignment: .leading) {
                        Text(map.displayName.uppercased())
                            .font(.system(size: 50, weight: .heavy))
                            .foregroundStyle(.white)
                        
                        if let coords = map.coordinates {
                            Text(coords)
                                .font(.callout)
                                .foregroundStyle(Color.valRed) // CORRECCIÓN: Color.valRed
                                .bold()
                        }
                    }
                    .padding()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "map.fill").foregroundStyle(Color.valRed) // CORRECCIÓN
                        Text("VISTA TÁCTICA //")
                            .font(.headline).bold()
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.top)
                    
                    ZStack {
                        Color.valDark.opacity(0.5).cornerRadius(12) // CORRECCIÓN
                        
                        AsyncImage(url: map.tacticalMapURL) { img in
                            img.resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                        } placeholder: {
                            ProgressView().tint(Color.valRed) // CORRECCIÓN
                        }
                    }
                    .frame(height: 350)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.valRed.opacity(0.5), lineWidth: 1) // CORRECCIÓN
                    )
                    
                    Text("PLANIFICACIÓN DE MISIÓN")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
        }
        .background(Color.valDark) 
        .navigationBarTitleDisplayMode(.inline)
    }
}
