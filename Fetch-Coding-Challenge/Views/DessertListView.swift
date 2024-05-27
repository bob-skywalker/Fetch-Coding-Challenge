//
//  ContentView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/25/24.
//

import SwiftUI

struct DessertListView: View {
    @StateObject var mealViewModel = MealViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical){
                ForEach(mealViewModel.meals) { dessert in
                    Text(dessert.dessertName)
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Fetch Dessert")
        }
    }
}

#Preview {
    @StateObject var mealViewModel = MealViewModel()
    
    return DessertListView(mealViewModel: mealViewModel)
}
