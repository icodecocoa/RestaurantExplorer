//
//  RestuarantExplorerApp.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/10/25.
//

import SwiftUI

@main
struct RestuarantExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RestaurantRepositoryImpl()
            let useCase = GetRestaurantsUseCase(repository: repository)
            RestaurantListView(viewModel: RestaurantListViewModel(useCase: useCase))
        }
    }
}
