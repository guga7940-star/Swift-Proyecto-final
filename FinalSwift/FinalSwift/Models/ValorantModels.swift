//
//  ValorantModels.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import Foundation

// La respuesta "envoltura" que nos da la API
struct AgentResponse: Codable {
    let status: Int
    let data: [Agent]
}

// El objeto principal: El Agente
struct Agent: Codable, Identifiable {
    let uuid: String
    let displayName: String
    let description: String
    let displayIcon: String?    // Icono pequeño
    let fullPortrait: String?   // Foto completa del personaje
    let role: Role?
    
    // 👇 ESTO ERA LO QUE FALTABA 👇
    let abilities: [Ability]?
    
    // Identifiable requiere un 'id', usamos el uuid único de Valorant
    var id: String { uuid }
    
    // Helpers para convertir String a URL de forma segura
    var iconURL: URL? {
        guard let displayIcon = displayIcon else { return nil }
        return URL(string: displayIcon)
    }
    
    var portraitURL: URL? {
        guard let fullPortrait = fullPortrait else { return nil }
        return URL(string: fullPortrait)
    }
}

// El Rol del agente (Duelista, Centinela, etc.)
struct Role: Codable {
    let displayName: String
    let description: String?
}

// 👇 NUEVA ESTRUCTURA PARA LAS HABILIDADES 👇
struct Ability: Codable, Hashable {
    let displayName: String
    let description: String
    let displayIcon: String?
    
    var iconURL: URL? {
        guard let displayIcon = displayIcon else { return nil }
        return URL(string: displayIcon)
    }
}

struct MapResponse: Codable {
    let status: Int
    let data: [GameMap]
}

// El objeto Mapa (Ascent, Bind, etc.)
struct GameMap: Codable, Identifiable {
    let uuid: String
    let displayName: String
    let splash: String?       // Imagen grande de carga
    let displayIcon: String?  // Imagen del minimapa vista aérea
    
    var id: String { uuid }
    
    // Helpers de URL
    var splashURL: URL? { splash != nil ? URL(string: splash!) : nil }
    var iconURL: URL? { displayIcon != nil ? URL(string: displayIcon!) : nil }
}

struct WeaponResponse: Codable {
    let status: Int
    let data: [Weapon]
}

// El objeto Arma
struct Weapon: Codable, Identifiable {
    let uuid: String
    let displayName: String
    let displayIcon: String?
    let shopData: ShopData? // Datos de compra (precio, categoría)
    let weaponStats: WeaponStats? // Estadísticas (daño, cargador)
    
    var id: String { uuid }
    
    // URL segura de la imagen
    var iconURL: URL? { displayIcon != nil ? URL(string: displayIcon!) : nil }
}

struct ShopData: Codable {
    let cost: Int
    let categoryText: String
}

struct WeaponStats: Codable {
    let fireRate: Double?
    let magazineSize: Int?
}
