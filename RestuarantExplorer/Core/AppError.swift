//
//  AppError.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

enum AppError: Error, LocalizedError {
    case network(description: String)
    case decoding(description: String)

    var errorDescription: String? {
        switch self {
        case .network(let description), .decoding(let description):
            return description
        }
    }
}
