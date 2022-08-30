//
//  TermView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlToLoad: String
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
    }
}
