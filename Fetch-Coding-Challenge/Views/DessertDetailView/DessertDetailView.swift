//
//  DessertDetailView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//

import SwiftUI
import Kingfisher

struct DessertDetailView: View {
    @EnvironmentObject var dessertDetailViewModel: DessertDetailViewModel
    let dessertId: String
    
    var body: some View {
        ScrollView {
            
            Text(dessertDetailViewModel.dessertDetail?.mealName ?? "")
                .font(.headline)
            
            KFImage(URL(string: dessertDetailViewModel.dessertDetail?.image ?? ""))
                .resizable()
                .scaledToFit()
                .padding()
        }
        .onAppear(perform: {
            dessertDetailViewModel.fetchDessertDetail(with: dessertId)
        })
    }
    
}

#Preview {
    @StateObject var dessertDetailViewModel = DessertDetailViewModel()
    
    return DessertDetailView(dessertId: "52893")
        .environmentObject(dessertDetailViewModel)
}
