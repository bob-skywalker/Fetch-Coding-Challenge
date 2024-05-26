//
//  ContentView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mealViewModel = MealViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical){
                ForEach(mealViewModel.meals) { meal in
                    Text(meal.mealName)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    @StateObject var mealViewModel = MealViewModel()
    
    return ContentView(mealViewModel: mealViewModel)
}
