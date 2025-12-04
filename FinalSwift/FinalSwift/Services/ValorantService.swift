//
//  ValorantService.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import Foundation

class ValorantService {
    // Singleton para usarlo fácilmente
    static let shared = ValorantService()
    
    // URL directa a la API oficial (Agentes en Español y Jugables)
    private let urlString = "https://valorant-api.com/v1/agents?language=es-MX&isPlayableCharacter=true"
    
    func fetchAgents() async throws -> [Agent] {
        // 1. Validar URL
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // 2. Hacer la petición (RT-4: async/await)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 3. Validar respuesta del servidor (200 OK)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // 4. Decodificar el JSON a nuestros Modelos
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
}
