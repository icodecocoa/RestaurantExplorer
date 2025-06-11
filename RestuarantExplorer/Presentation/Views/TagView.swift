//
//  TagView.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

import SwiftUI

struct TagView: View {
    let text: String
    let backgroundColor: Color
    let textColor: Color

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .clipShape(Capsule())
    }
}
