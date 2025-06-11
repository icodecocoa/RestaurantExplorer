//
//  Restaurant.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import Foundation

// MARK: - Domain Layer

// MARK: - RestuarantListData
struct RestuarantListData: Codable {
    let restaurants: [Restaurant]?
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "data"
    }
}

// MARK: - RestuarantData
struct RestuarantData: Codable {
    let restaurant: Restaurant?
    
    enum CodingKeys: String, CodingKey {
        case restaurant = "data"
    }
}

// MARK: - Retaurant
struct Restaurant: Identifiable, Codable {
    let id: String
    let type: DatumType
    let attributes: Attributes?
}

//MARK: - DatumType
enum DatumType: String, Codable {
    case restaurant = "restaurant"
}
