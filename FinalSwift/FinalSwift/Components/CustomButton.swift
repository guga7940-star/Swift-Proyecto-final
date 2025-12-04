//
//  CustomButton.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 04/12/25.
//


import SwiftUI

struct CustomButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 3)
        }
    }
}
