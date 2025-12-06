//
//  ValorantModels.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import Foundation

// --- AGENTES ---
struct AgentResponse: Codable {
    let status: Int
    let data: [Agent]
}

struct Agent: Codable, Identifiable {
    let uuid: String
    let displayName: String
    let description: String
    let displayIcon: String?
    let fullPortrait: String?
    let role: Role?
    let abilities: [Ability]?
    
    var id: String { uuid }
    
    var iconURL: URL? { displayIcon != nil ? URL(string: displayIcon!) : nil }
    var portraitURL: URL? { fullPortrait != nil ? URL(string: fullPortrait!) : nil }
}

struct Role: Codable {
    let displayName: String
    let description: String?
}

struct Ability: Codable, Hashable {
    let displayName: String
    let description: String
    let displayIcon: String?
    
    var iconURL: URL? { displayIcon != nil ? URL(string: displayIcon!) : nil }
}

struct MapResponse: Codable {
    let status: Int
    let data: [GameMap]
}

struct GameMap: Codable, Identifiable {
    let uuid: String
    let displayName: String
    let splash: String?
    let displayIcon: String?
    let coordinates: String?
    let listViewIcon: String?
    
    var id: String { uuid }
    
    var splashURL: URL? { splash != nil ? URL(string: splash!) : nil }
    
    var tacticalMapURL: URL? { displayIcon != nil ? URL(string: displayIcon!) : nil }
    
    var listIconURL: URL? { listViewIcon != nil ? URL(string: listViewIcon!) : nil }
}

struct WeaponResponse: Codable {
    let status: Int
    let data: [Weapon]
}

struct Weapon: Codable, Identifiable {
    let uuid: String
    let displayName: String
    let displayIcon: String?
    let shopData: ShopData?
    let weaponStats: WeaponStats?
    
    var id: String { uuid }
    
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
