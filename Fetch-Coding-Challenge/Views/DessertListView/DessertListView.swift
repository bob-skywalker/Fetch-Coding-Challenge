//
//  ContentView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/25/24.
//

import SwiftUI
import Kingfisher


struct DessertListView: View {
    @EnvironmentObject var dessertViewModel: DessertViewModel
    
    //State Management for toggling between light & dark mode
    @State var isDarkMode: Bool = false
    @State var colorScheme: ColorScheme = .light
    
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
                        NavigationLink(value: meal) {
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
                                    .padding(5)
                                    .background(colorScheme == .dark ? .black : .white)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black).bold()
                                    .font(.caption)
                                    .clipShape(RoundedRectangle(cornerRadius: 11))
                                    .offset(y: -10)
                                
                            }
                            .padding(.horizontal, 2)
                        }
                    }
                })
            }
            //utilizes navigationDestination for performance optimization
            .navigationDestination(for: Dessert.self, destination: { dessert in
                DessertDetailView(isDarkMode: $isDarkMode, colorScheme: $colorScheme, dessertId: dessert.id, image: KFImage(URL(string: dessert.image)), dessertName: dessert.dessertName)
            })
            .scrollIndicators(.hidden)
            .navigationTitle("Fetch Dessert")
            
            //Togging the state for colorScheme between light and dark
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        updateColorScheme()
                    }, label: {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .foregroundStyle(isDarkMode ? .white : .black)
                    })
                }
            })
            .refreshable {
                dessertViewModel.fetchMeals()
            }
            
        }
        .preferredColorScheme(colorScheme)
    }
    
    //toggle between user colorScheme state
    func updateColorScheme() {
        withAnimation(.easeIn(duration: 0.20)) {
            let heavyTouch = UIImpactFeedbackGenerator(style: .heavy)
            heavyTouch.impactOccurred()
            isDarkMode.toggle()
            colorScheme = isDarkMode ? .dark : .light
        }
    }
}

#Preview {
    @StateObject var dessertViewModel = DessertViewModel()
    
    return DessertListView()
        .environmentObject(dessertViewModel)
}
