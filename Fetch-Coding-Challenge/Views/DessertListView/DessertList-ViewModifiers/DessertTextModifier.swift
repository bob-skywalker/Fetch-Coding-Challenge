//
//  DessertListViewText.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//

import SwiftUI

struct DessertTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(.black.opacity(0.65))
            .foregroundStyle(.white).bold()
            .font(.callout)
            .clipShape(RoundedRectangle(cornerRadius: 11))
            .offset(y: -10)
    }
}

extension View {
    func dessertTextModifier() -> some View {
        modifier(DessertTextModifier())
    }
}
