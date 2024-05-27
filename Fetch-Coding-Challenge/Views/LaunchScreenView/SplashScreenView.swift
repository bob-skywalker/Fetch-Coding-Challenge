//
//  SplashScreenView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/26/24.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding var isPresented: Bool
    
    let animationAmount = 0.5
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var opacity = 1.0
    
    
    var body: some View {
        ZStack{
            Color.yellow.ignoresSafeArea()
            
            VStack(spacing: 25){

                Image("fetch-loading")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .offset(x: 1)
                
                Text("Fetch Rewards")
                    .font(.system(.largeTitle, design: .serif))
                    .foregroundStyle(.black)
            }
            .scaleEffect(scale)

        }
        .opacity(opacity)
        .onAppear(perform: {
            withAnimation(.spring(duration: 1.6, bounce: 0.65)) {
                scale = CGSize(width: 1, height: 1)
            }

            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 , execute: {
                withAnimation(.easeIn(duration: 0.25)){
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0
                }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8 , execute: {
                withAnimation(.easeIn(duration: 0.2)){
                    isPresented.toggle()
                }
            })
        })
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
