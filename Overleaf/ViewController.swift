//
//  ViewController.swift
//  Overleaf
//
//  Created by Andy Gray on 10/01/2024.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        webView.navigationDelegate = self
        webView.navigationDelegate = self
        
        // Load Overleaf website when the app starts
        if let url = URL(string: "https://www.overleaf.com/login?") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // WKNavigationDelegate methods
    //    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    //        print("Page loaded successfully")
    //    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed to load page with error: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // You can update UI or show loading indicators if needed
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            grabWebPageTitleFromHead()
        }

        // Method to grab the webpage title from the <head> section
    private func grabWebPageTitleFromHead() {
        webView.evaluateJavaScript("document.head.querySelector('title').text") { (result, error) in
            if let title = result as? String {
                // Extract text up until " - " and remove everything after it
                if let index = title.range(of: " - ")?.lowerBound {
                    let truncatedTitle = title[..<index]
                    let finalTitle = String(truncatedTitle)
                    
                    // Use the final title as needed
                    self.view.window?.title = finalTitle
                } else {
                    // If " - " is not found, use the original title
                    self.view.window?.title = title
                }
            }
        }
    }
}
