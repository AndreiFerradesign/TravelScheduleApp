//
//  ContentView.swift
//  TravelScheduleApp
//
//  Created by Andrei Kashin on 13.03.2024.
//

import SwiftUI
import OpenAPIURLSession
import HTTPTypes

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Для теста нажмите нужную кнопку")
                .bold()
            Spacer()
            
            Button {
                search()
            } label: {
                Text("Расписание рейсов между станциями")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                schedule()
            } label: {
                Text("Расписание рейсов по станции")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                thread()
            } label: {
                Text("Список станций следования")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                stations()
            } label: {
                Text("Список ближайших станций")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                settlement()
            } label: {
                Text("Ближайший город")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                carrier()
            } label: {
                Text("Информация о перевозчике")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                stationList()
            } label: {
                Text("Список всех доступных станций")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                copyright()
            } label: {
                Text("Копирайт Яндекс Расписаний")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }
    
    func search() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = RoutesSearchService (
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let result = try await service.search(from: Constants.Cities.kazan, to: Constants.Cities.moscow,  date: Constants.currentDate)
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func schedule() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ScheduleSearchService (
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let result = try await service.search(station: Constants.StationCode.airportKazan, date: Constants.currentDate)
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func thread() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ThreadService(
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let thread = try await service.search(uid: Constants.threadUID)
                print(thread)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    func stations() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let stations = try await service.getNearestStations(lat:
                                                                        59.864177, lng: 30.319163, distance: 50)
                print(stations)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func settlement() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let result = try await service.getNearestSSettlement(lat: 55.7887, lng: 49.1221)
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func carrier() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CarrierService(
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let thread = try await service.search(code: "EK", system: .iata)
                print(thread)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    func stationList() {
        
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = StationListService(
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let stations = try await service.get()
                let data = try await Data(collecting: stations, upTo: 100*1024*1024)
                print("data size: \(data.count)")
                let allStations = try JSONDecoder().decode(Components.Schemas.AllStations.self, from: data)
                print("All stations: \(allStations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func copyright() {
        let client = Client (
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = CopyrightService(
            client: client,
            apikey: Constants.apiKey
        )
        
        Task {
            do {
                let copyright = try await service.getCopyright()
                print(copyright)
            } catch {
                print("Ошибка  \(error)")
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
