//
//  VenueCardView.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

struct VenueCardView: View {
    let venue: Restaurant

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                if let urlString = venue.attributes?.imageURL,
                   let url = URL(string: urlString) {
                    CachedAsyncImage(url: url) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Rectangle().fill(Color.gray.opacity(0.3))
                    }
                    .frame(width: 180, height: 120)
                    .clipped()
                    .cornerRadius(12)
                }

                if let rating = venue.attributes?.ratingsAverage {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text(rating)
                    }
                    .font(.caption)
                    .padding(6)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .padding(6)
                }
            }

            Text(venue.attributes?.name ?? "Unknown")
                .font(.subheadline)
                .bold()

            if let cuisine = venue.attributes?.cuisine {
                Label(cuisine, systemImage: "fork.knife")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if let price = venue.attributes?.priceLevel {
                Text(String(repeating: "$", count: min(max(price, 1), 5)))
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 180)
    }
}
