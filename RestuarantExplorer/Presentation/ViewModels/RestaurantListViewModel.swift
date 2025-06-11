//
//  RestaurantListViewModel.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

@MainActor
final class RestaurantListViewModel: ObservableObject {
    @Published var state: ViewState<[Restaurant]> = .loading
    private let useCase: GetRestaurantsUseCase

    init(useCase: GetRestaurantsUseCase) {
        self.useCase = useCase
    }

    func fetchRestaurants() {
        Task {
            do {
                let restaurants = try await useCase.execute()
                state = .success(restaurants)
            } catch {
                state = .failure(error)
            }
        }
    }
}
