//
//  ValorantService.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import Foundation

class ValorantService {
    static let shared = ValorantService()
    
    private let urlString = "https://valorant-api.com/v1/agents?language=es-MX&isPlayableCharacter=true"
    
    func fetchAgents() async throws -> [Agent] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(AgentResponse.self, from: data)
        return decodedResponse.data
    }
    
    private let mapsURL = "https://valorant-api.com/v1/maps?language=es-MX"
        
        func fetchMaps() async throws -> [GameMap] {
            guard let url = URL(string: mapsURL) else { throw URLError(.badURL) }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decoded = try JSONDecoder().decode(MapResponse.self, from: data)
            return decoded.data
        }
    private let weaponsURL = "https://valorant-api.com/v1/weapons?language=es-MX"
        
        func fetchWeapons() async throws -> [Weapon] {
            guard let url = URL(string: weaponsURL) else { throw URLError(.badURL) }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decoded = try JSONDecoder().decode(WeaponResponse.self, from: data)
            return decoded.data
        }

}

