//
//  DessertDetailView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//

import SwiftUI
import Kingfisher

struct DessertDetailView: View {
    
    //Passing the state for colorScheme Setting from ListView
    @Binding var isDarkMode: Bool
    @Binding var colorScheme: ColorScheme
    
    //Toggle the state to show or hide Youtube WebKit View
    @State private var isShowingYoutube: Bool = false
    
    @EnvironmentObject var dessertDetailViewModel: DessertDetailViewModel
    
    //For fetching Dessert Details
    let dessertId: String
    
    //Using the same KFImage so the view won't go and fetch new image that would cause re-render
    let image: KFImage
    let dessertName: String
    
    //computed property for dessert Youtube
    var dessertYoutubeLink: String? {
        dessertDetailViewModel.dessertDetail?.youtubeLink
    }
    
    //computed property for dessert Ingredients
    var dessertIngredientsArray: [String] {
        dessertDetailViewModel.dessertDetail?.ingredientDescription.split(whereSeparator: \.isNewline).map({ subString in
            String(subString)
        }) ?? [""]
    }
    
    
    var body: some View {
        
        ScrollView{
            
            VStack(alignment: .leading, spacing: 10){
                ZStack(alignment: .bottom, content: {
                    
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    
                })
                
                if dessertDetailViewModel.isLoading {
                    GeometryReader(content: { geo in
                        ProgressView("Loading...")
                            .progressViewStyle(.circular)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .background(Color.black.opacity(0.3))
                            .ignoresSafeArea()
                    })
                    
                } else {
                    
                    HStack {
                        Text("Instruction:")
                            .font(.title)
                        Spacer()
                        
                        if dessertYoutubeLink != nil {
                            
                            Button(action: {
                                isShowingYoutube = true
                            }, label: {
                                HStack(spacing:3){
                                    Image("youtube")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("Youtube")
                                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                                        .font(.callout)
                                }
                            })
                        }
                        
                    }
                    //custom shadow filter for a slightly accented font format
                    .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.2)
                    
                    Divider()
                    
                    
                    VStack(alignment: .leading){
                        Text(dessertDetailViewModel.dessertDetail?.instructions ?? "")
                        
                        Divider()
                        
                        Text("Ingredients: ")
                            .font(.title)
                            .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.2)
                        
                        
                        
                        ForEach(dessertIngredientsArray, id: \.self) { ingredient in
                            Button(action: {
                                //haptic feedback on user taps
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                            }, label: {
                                Text(ingredient)
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .font(.callout)
                                
                                
                            })
                            .background(isDarkMode ?  .blue : .teal)
                            .foregroundStyle(isDarkMode ?  .white : .black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                
                
                
                
            }
            .padding()
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    updateColorScheme()
                }, label: {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                        .foregroundStyle(isDarkMode ? .white : .black)
                })
                
            }
        }
        
        .sheet(isPresented: $isShowingYoutube, content: {
            YoutubeView(url: URL(string: dessertYoutubeLink!)!)
        })
        .navigationTitle(dessertName)
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .onAppear(perform: {
            dessertDetailViewModel.fetchDessertDetail(with: dessertId)
        })
        
        
    }
    
    func updateColorScheme() {
        withAnimation(.easeOut(duration: 0.4)){
            isDarkMode.toggle()
            colorScheme = isDarkMode ? .dark : .light
        }
    }
    
    
}

#Preview {
    @StateObject var dessertDetailViewModel = DessertDetailViewModel()
    
    return DessertDetailView(isDarkMode: .constant(true), colorScheme: .constant(.dark), dessertId: "52893", image: KFImage(URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")), dessertName: "Apple & Blackberry Crumble")
        .environmentObject(dessertDetailViewModel)
        .preferredColorScheme(.dark)
}
