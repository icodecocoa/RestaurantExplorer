//
//  ViewState.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

// MARK: - ViewState

enum ViewState<T> {
    case loading
    case success(T)
    case failure(Error)
}
