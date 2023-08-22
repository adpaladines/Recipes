//
//  YoutubeView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/9/23.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let completeUrl: String?
    let videoId: String?
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        var url: URL?
        if let completeUrl = completeUrl {
            let myVideoId = completeUrl.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
            url = URL(string: "https://www.youtube.com/embed/\(myVideoId)")
        }else if let videoId = videoId {
            url = URL(string: "https://www.youtube.com/embed/\(videoId)")
        }
        let demoURL = url ?? URL(string: "https://www.youtube.com/embed/5TxnwlDn7w0")!
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}


struct YouTubeView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeView(completeUrl: nil, videoId: "1IszT_guI08")
    }
}
