//
//  LaunchScreenView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//

import SwiftUI

struct ContainerView: View {
    @State private var isSplashScreenViewPresented: Bool = true
    @StateObject var dessertDetailViewModel: DessertDetailViewModel = DessertDetailViewModel()
    @StateObject var dessertListViewModel: DessertViewModel = DessertViewModel()

    
    var body: some View {
        if !isSplashScreenViewPresented {
            DessertListView()
                .environmentObject(dessertDetailViewModel)
                .environmentObject(dessertListViewModel)
        } else {
            SplashScreenView(isPresented: $isSplashScreenViewPresented)
        }
    }
}

#Preview {
    ContainerView()
}
