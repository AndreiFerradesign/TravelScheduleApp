//
//  ScheduleService.swift
//  TravelScheduleApp
//
//  Created by Andrei Kashin on 13.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Schedule = Components.Schemas.SingleStationRoutes

protocol ScheduleSearchServiceProtocol {
  func search(station: String, date: String) async throws -> Schedule
}

final class ScheduleSearchService: ScheduleSearchServiceProtocol {
  private let client: Client
  private let apikey: String
  
  init(client: Client, apikey: String) {
    self.client = client
    self.apikey = apikey
  }
  
func search(station: String, date: String) async throws -> Schedule {

    let response = try await client.schedule(query: .init(
        apikey: apikey,
        station: station,
        date: date
    ))
    return try response.ok.body.json
  }
}
