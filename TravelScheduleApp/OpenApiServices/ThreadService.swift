//
//  ThreadService.swift
//  TravelScheduleApp
//
//  Created by Andrei Kashin on 13.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.SingleThread

protocol ThreadServiceProtocol {
    func search(uid: String) async throws -> Thread
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func search(uid: String) async throws -> Thread {
        
        let response = try await client.thread(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
