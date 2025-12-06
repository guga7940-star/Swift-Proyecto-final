//
//  ValorantViewModel.swift
//  FinalSwift
//
//  Created by Gustavo Núñez Duque on 03/12/25.
//

import Foundation
import Observation

@Observable
class ValorantViewModel {
    var isLoading = false
    var errorMessage: String? = nil
    var maps: [GameMap] = []
    var weapons: [Weapon] = []
    var agents: [Agent] = []

    private let service = ValorantService.shared
    
    func loadAgents() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedAgents = try await service.fetchAgents()
            self.agents = fetchedAgents
            self.isLoading = false
            
        } catch {
            self.errorMessage = "Error: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
    
    func loadMaps() async {
            isLoading = true
            errorMessage = nil
            do {
                self.maps = try await service.fetchMaps()
                isLoading = false
            } catch {
                self.errorMessage = "Error mapas: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    
    func loadWeapons() async {
            isLoading = true
            errorMessage = nil
            do {
                self.weapons = try await service.fetchWeapons()
                isLoading = false
            } catch {
                self.errorMessage = "Error armas: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
}

