//
//  RestaurantDetailViewModel.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

@MainActor
final class RestaurantDetailViewModel: ObservableObject {
    @Published var state: ViewState<Restaurant> = .loading
    private let useCase: GetRestaurantDetailsUseCase
    private let id: String

    init(id: String, useCase: GetRestaurantDetailsUseCase) {
        self.id = id
        self.useCase = useCase
    }

    func fetchDetails() {
        Task {
            do {
                let restaurant = try await useCase.execute(id: id)
                state = .success(restaurant)
            } catch {
                state = .failure(error)
            }
        }
    }
}
