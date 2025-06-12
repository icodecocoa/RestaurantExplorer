//
//  RestaurantListViewModel.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI
import Combine

@MainActor
final class RestaurantListViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                if !text.isEmpty {
                    print(text)
                    self.searchRestaurants(text: text)
                }
            }
            .store(in: &cancellables)
    }
    @Published var state: ViewState<[Restaurant]> = .loading
    private let useCase: GetRestaurantsUseCase

    init(useCase: GetRestaurantsUseCase) {
        self.useCase = useCase
        setupSearchDebounce()
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
    
    func searchRestaurants(text: String) {
        Task {
            do {
                let restaurants = try await useCase.executeSearch(query: text)
                state = .success(restaurants)
            } catch {
                state = .failure(error)
            }
        }
    }
}
