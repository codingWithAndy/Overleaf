//
//  ViewController.swift
//  Overleaf
//
//  Created by Andy Gray on 10/01/2024.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        webView.navigationDelegate = self
        
        // Load Overleaf website when the app starts
        if let url = URL(string: "https://www.overleaf.com/login?") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Page loaded successfully")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed to load page with error: \(error.localizedDescription)")
    }
    
}
