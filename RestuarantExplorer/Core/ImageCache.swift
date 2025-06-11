//
//  RestuarantExplorerApp.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/10/25.
//

import SwiftUI

//ImageCache - is a mechanism used to temporarily store images in memory to improve performance and reduce unnecessary network requestsimport SwiftUI

class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
}

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    let url: URL
    let content: (Image) -> Content
    let placeholder: () -> Placeholder

    @State private var loadedImage: UIImage?

    var body: some View {
        if let image = loadedImage {
            content(Image(uiImage: image))
        } else if let cached = ImageCache.shared.image(for: url) {
            content(Image(uiImage: cached))
        } else {
            placeholder()
                .onAppear { loadImage() }
        }
    }

    private func loadImage() {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    ImageCache.shared.insertImage(image, for: url)
                    loadedImage = image
                }
            } catch {
                // Handle error silently or show placeholder
            }
        }
    }
}
