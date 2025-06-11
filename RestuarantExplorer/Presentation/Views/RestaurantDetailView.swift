//
//  RestaurantDetailView.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    @StateObject private var viewModel: RestaurantDetailViewModel
    @Environment(\.dismiss) var dismiss

    init(id: String) {
        let repository = RestaurantRepositoryImpl()
        let useCase = GetRestaurantDetailsUseCase(repository: repository)
        _viewModel = StateObject(wrappedValue: RestaurantDetailViewModel(id: id, useCase: useCase))
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView("Loading Details…")
                    .progressViewStyle(CircularProgressViewStyle())
            case .success(let restaurant):
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        imageHeaderView(for: restaurant)
                        detailsCardView(for: restaurant)
                        locationMenuView(for: restaurant)
                        notes(for: restaurant)
                        tags(for: restaurant)
                        otherVenues(for: restaurant)
                    }
                    .padding(.bottom)
                }
            case .failure(let error):
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .onAppear { viewModel.fetchDetails() }
        .navigationBarHidden(true)
    }
    
    // MARK: - Image Header
    private func imageHeaderView(for restaurant: Restaurant) -> some View {
        ZStack(alignment: .topLeading) {
            if let attributes = restaurant.attributes,
               let urlString = attributes.imageURL,
               let url = URL(string: urlString) {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(height: 240)
                .clipped()
            } else {
                Image("venue_header") // fallback image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 240)
                    .clipped()
            }

            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "chevron.left")
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding()

                Spacer()
            }
        }
    }
    
    // MARK: - Card section
    private func detailsCardView(for restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(restaurant.attributes?.name ?? "")
                    .font(.title2)
                    .bold()
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                Text(restaurant.attributes?.ratingsAverage ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Text(restaurant.attributes?.description ?? "")
                .font(.body)
                .foregroundColor(.secondary)
            
            // Tags
            HStack(spacing: 12) {
                let priceLevel = min(max(restaurant.attributes?.priceLevel ?? 1, 1), 5)
                let priceString = String(repeating: "$", count: priceLevel)

                Label(priceString, systemImage: "dollarsign.circle")
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Capsule())
                      
                Label(restaurant.attributes?.establishmentType ?? "", systemImage: "fork.knife")
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(Color.yellow.opacity(0.1))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color.white)
    }
    
    // MARK: - Location & Menu
    func locationMenuView(for restuarant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: {
                let googleMapsURL = URL(string: "https://www.google.com/maps/search/?api=1&query=\(restuarant.attributes?.latitude ?? 0.0),\(restuarant.attributes?.longitude ?? 0.0)")!
                    if UIApplication.shared.canOpenURL(googleMapsURL) {
                        UIApplication.shared.open(googleMapsURL)
                    }
            }) {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.black)
                    VStack(alignment: .leading) {
                        Text((restuarant.attributes?.addressLine1 ?? "") + ", " + (restuarant.attributes?.addressLine2 ?? ""))
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        Text("See venue's address in google maps")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
            
            // Menu
            Button(action: {
                if let attributes = restuarant.attributes, let menuURLString = attributes.menuURL, let menuURL = URL(string: menuURLString) {
                    if UIApplication.shared.canOpenURL(menuURL) {
                        UIApplication.shared.open(menuURL)
                    }
                }
            }) {
                HStack {
                    Image(systemName: "doc.text.fill")
                        .foregroundColor(.black)
                    VStack(alignment: .leading) {
                        Text("Restaurant menu")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        Text("See restaurant menu in pdf")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Notes
    func notes(for restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notes from the restaurant")
                .font(.headline)
            Text(restaurant.attributes?.description ?? "")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    // MARK: - Tags Section
    func tags(for restaurant: Restaurant) -> some View {
        VStack(alignment: .leading) {
            Text("Amenities & Features")
                .font(.headline)
                .padding(.horizontal)
            
            let tags = restaurant.attributes?.labels ?? []
            
            WrappingTagsView(tags: tags)
        }
        .padding(.horizontal)
    }

    //MARK: - Other Venues Section
    func otherVenues(for restaurant: Restaurant) -> some View {
        VStack {
            VenueSectionView(
                title: "Other venues with \(restaurant.attributes?.establishmentType ?? "")",
                venues: [
                    Restaurant(id: UUID().uuidString, type: .restaurant, attributes: Attributes(name: "A Casa do Porco", cuisine: "Italian Fine Dining", imageURL: "venue1", ratingsAverage: "4.8")),
                    Restaurant(id: UUID().uuidString, type: .restaurant, attributes: Attributes(name: "Septime", cuisine: "Italian Fine Dining", imageURL: "venue2", ratingsAverage: "4.8")),
                    Restaurant(id: UUID().uuidString, type: .restaurant, attributes: Attributes(name: "Odette", cuisine: "Italian Fine Dining", imageURL: "venue3", ratingsAverage: "4.8"))
                ]
            )
            VenueSectionView(
                title: "Other venues in \(restaurant.attributes?.addressLine2 ?? "")",
                venues: [
                    Restaurant(id: UUID().uuidString, type: .restaurant, attributes: Attributes(name: "Disfrutar", cuisine: "Italian Fine Dining", imageURL: "venue4", ratingsAverage: "4.8")),
                    Restaurant(id: UUID().uuidString, type: .restaurant, attributes: Attributes(name: "Central", cuisine: "International", imageURL: "venue5", ratingsAverage: "4.8")),
                    Restaurant(id: UUID().uuidString, type: .restaurant, attributes: Attributes(name: "Odette", cuisine: "Asian", imageURL: "venue6", ratingsAverage: "4.8"))
                ]
            )
        }
    }
    
    //MARK: - Venue Section View
    struct VenueSectionView: View {
        let title: String
        let venues: [Restaurant]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(venues) { venue in
                            VenueCardView(venue: venue)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom)
        }
    }
}

