//
//  DessertTextView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//

import SwiftUI

//Refactored into its own View Component for reusability
struct DessertTextView: View {
    let dessertName: String
    
    var body: some View {
        Text(dessertName)
    }
}

#Preview {
    let testDessert: String = "Apple & Blackberry Crumble"
    
    return DessertTextView(dessertName: testDessert)
}
