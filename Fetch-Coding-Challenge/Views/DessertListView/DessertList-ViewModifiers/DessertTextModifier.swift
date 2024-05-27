//
//  DessertListViewText.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//

import SwiftUI

struct DessertTextModifier: ViewModifier {
    
    //Custom configuration for monitoring user's light/dark mode setting
    @Environment(\.colorScheme) var colorScheme
     
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(colorScheme == .dark ? .black : .white)
            .foregroundStyle(colorScheme == .dark ? .white : .black).bold()
            .font(.caption)
            .clipShape(RoundedRectangle(cornerRadius: 11))
            .offset(y: -10)
    }
}

extension View {
    func dessertTextModifier() -> some View {
        modifier(DessertTextModifier())
    }
}
