//
//  MyViewController.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/22/23.
//

import UIKit
import WebKit

class MyViewController: UIViewController {
    
    var urlString: String?
    
    @IBOutlet weak var webView: WKWebView!
    var mainCoordinator: MainCoordinator?
    
    
    @IBAction func buttonActionTap(_ sender: Any) {
        guard let coord = mainCoordinator else  {
            return
        }
        coord.path.removeLast()
        
        let stack = UIStackView()
        let vieww = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
    }
    
    func setWebView() {
        guard
            let string = urlString
        else {
            return
        }
        
        let encodedQuery = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "https://appletoolbox.com/how-to-undo-a-jailbreak/") {
            webView.navigationDelegate = self
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}

extension MyViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading!")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        guard let host = webView.url?.host(), (host == "www.google.com" || host == "appletoolbox.com") else {
            return .cancel
        }
        return .allow
    }
    
}
