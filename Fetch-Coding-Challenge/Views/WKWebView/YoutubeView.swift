//
//  WKWebView.swift
//  Fetch-Coding-Challenge
//
//  Created by Bo Zhong on 5/27/24.
//

import SwiftUI
import WebKit

struct YoutubeView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    YoutubeView(url: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg&ab_channel=CheNom")!)
}
