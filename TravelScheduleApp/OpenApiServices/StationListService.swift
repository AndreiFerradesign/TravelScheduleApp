//
//  StationListService.swift
//  TravelScheduleApp
//
//  Created by Andrei Kashin on 13.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationList = Components.Schemas.AllStations

protocol StationListServiceProtocol {
    func get(format: Operations.getAllStations.Input.Query.formatPayload) async throws -> HTTPBody
}

final class StationListService: StationListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func get(format: Operations.getAllStations.Input.Query.formatPayload = .json) async throws -> HTTPBody {
        
        let response = try await client.getAllStations(query: .init(
            apikey: apikey,
            format: format
        ))
        return try response.ok.body.html
    }
}
