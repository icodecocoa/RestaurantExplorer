//
//  RestaurantRepositoryImpl.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

protocol RestaurantRepository {
    func getRestaurants() async throws -> [Restaurant]
    func getRestaurantDetails(id: String) async throws -> Restaurant
}

struct GetRestaurantsUseCase {
    let repository: RestaurantRepository

    func execute() async throws -> [Restaurant] {
        try await repository.getRestaurants()
    }
}

struct GetRestaurantDetailsUseCase {
    let repository: RestaurantRepository

    func execute(id: String) async throws -> Restaurant {
        try await repository.getRestaurantDetails(id: id)
    }
}

final class RestaurantRepositoryImpl: RestaurantRepository {
    private let baseURL = URL(string: "https://api.eat-sandbox.co/consumer/v2/restaurants")!

    func getRestaurants() async throws -> [Restaurant] {
        let url = baseURL.appending(queryItems: [
            URLQueryItem(name: "region_id", value: "3906535a-d96c-47cf-99b0-009fc9e038e0")
        ])
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let restaurantList = try JSONDecoder().decode(RestuarantListData.self, from: data)
            if let restaurants = restaurantList.restaurants {
                return restaurants
            } else {
                throw AppError.decoding(description: "Restaurants not obtained")
            }
        } catch {
            throw AppError.decoding(description: "Failed to decode restaurant list")
        }
    }

    func getRestaurantDetails(id: String) async throws -> Restaurant {
        let url = baseURL.appendingPathComponent(id)
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let restaurant = try JSONDecoder().decode(RestuarantData.self, from: data)
            if let restaurant = restaurant.restaurant {
                return restaurant
            } else {
                throw AppError.decoding(description: "Restaurant detail not obtained")
            }
        } catch {
            throw AppError.decoding(description: "Failed to decode restaurant details")
        }
    }
}
