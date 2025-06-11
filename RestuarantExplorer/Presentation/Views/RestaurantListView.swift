//
//  RestaurantListView.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

struct RestaurantListView: View {
    @StateObject var viewModel: RestaurantListViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading…")
                        .progressViewStyle(CircularProgressViewStyle())
                case .success(let restaurants):
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(restaurants) { restaurant in
                                RestaurantCardView(restaurant: restaurant)
                            }
                        }
                        .padding()
                    }
                case .failure(let error):
                    VStack{
                        Button(action: { viewModel.fetchRestaurants() }) {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .font(.title)
                                .foregroundStyle(.red)
                        }
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
            .onAppear { viewModel.fetchRestaurants() }
            .navigationTitle("Restaurants")
        }
    }
}
