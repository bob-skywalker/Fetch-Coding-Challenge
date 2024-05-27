//
//  ContentView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/25/24.
//

import SwiftUI
import Kingfisher


struct DessertListView: View {
    @StateObject var dessertViewModel = DessertViewModel()
    
    //adopts an adaptive grid size that fits different screen sizes
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical){
                
                //utilizes a LazyVGrid for performance optimization
                LazyVGrid(columns: columns, content: {
                    ForEach(dessertViewModel.meals) { meal in
                        ZStack(alignment: .bottom){
                            
                            KFImage(URL(string: meal.image))
                            
                            //Custom loading screen for fetch reward
                                .placeholder({
                                    Image("fetch-loading")
                                })
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .padding(1.5)
                                .overlay {
                                    Rectangle()
                                        .stroke()
                                        .foregroundStyle(LinearGradient(colors: [.yellow, .black], startPoint: .leading, endPoint: .bottomTrailing))
                                        .clipShape(RoundedRectangle(cornerRadius: 11))
                                    
                                }
                            
                            //Refactored into its own SwiftUI View & ViewModifier for reusability
                            DessertTextView(dessertName: meal.dessertName)
                            
                        }
                        
                        
                    }
                })
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Fetch Dessert")
            
        }
    }
}

#Preview {
    @StateObject var dessertViewModel = DessertViewModel()
    
    return DessertListView(dessertViewModel: dessertViewModel)
}
