//
//  RestaurantCardView.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurant: Restaurant

    var body: some View {
        NavigationLink(destination: RestaurantDetailView(id: restaurant.id)) {
            VStack(alignment: .leading, spacing: 8) {
                Text(restaurant.attributes?.name ?? "No Name")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 4)
                HStack {
                    Text(restaurant.attributes?.addressLine1 ?? "No Address")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                    Text(restaurant.attributes?.ratingsAverage ?? "")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                    
                }
                if let attributes = restaurant.attributes,
                   let urlString = attributes.imageURL,
                   let url = URL(string: urlString) {
                    
                    ZStack(alignment: .bottomLeading) {
                        // Background Image
                        CachedAsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        }
                        .frame(height: 200)
                        .clipped()
                        
                        // Overlay Tags (Price & Cuisine)
                        VStack(alignment: .leading, spacing: 8) {
                            if let priceLevel = attributes.priceLevel {
                                TagView(text: String(repeating: "$", count: min(max(priceLevel, 1), 5)),
                                        backgroundColor: Color(.systemGray6),
                                        textColor: Color(.black))
                            }
                            if let cuisine = attributes.cuisine {
                                TagView(text: cuisine,
                                        backgroundColor: Color(.systemGray6),
                                        textColor: Color(.black))
                            }
                        }
                        .padding([.leading, .bottom], 12) // Bottom-left alignment padding
                    }
                    .cornerRadius(16)
                    .padding(.bottom, 16) // Space *below* the image view
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
