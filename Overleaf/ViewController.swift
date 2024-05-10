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



//WebKitWebKit
//Explore
//To allow your app to download a PDF file from a web app like Overleaf using WebKit, you can use the WKNavigationDelegate protocol’s decidePolicyFor navigationResponse method1. This method is called each time the page wants to redirect to a new URL1.
//
//Here’s a simplified example of how you might implement this:
//
//Swift
//
//import WebKit
//
//class ViewController: UIViewController, WKNavigationDelegate {
//    var webView: WKWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view.addSubview(webView)
//
//        if let url = URL(string: "https://www.overleaf.com") {
//            webView.load(URLRequest(url: url))
//        }
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        if let mimeType = navigationResponse.response.mimeType, mimeType == "application/pdf" {
//            if let url = navigationResponse.response.url {
//                downloadData(fromURL: url) { success, destinationURL in
//                    if success, let destinationURL = destinationURL {
//                        // Handle the downloaded file at destinationURL
//                    }
//                }
//                decisionHandler(.cancel)
//                return
//            }
//        }
//        decisionHandler(.allow)
//    }
//
//    func downloadData(fromURL url: URL, completion: @escaping (Bool, URL?) -> Void) {
//        let downloadTask = URLSession.shared.downloadTask(with: url) { url, response, error in
//            guard let url = url else {
//                completion(false, nil)
//                return
//            }
//            completion(true, url)
//        }
//        downloadTask.resume()
//    }
//}
//AI-generated code. Review and use carefully. More info on FAQ.
//In this code, the decidePolicyFor navigationResponse method checks if the MIME type of the response is "application/pdf". If it is, it downloads the data from the URL and cancels the navigation1. The downloadData(fromURL:completion:) method uses URLSession to download the file and calls the completion handler with the URL of the downloaded file1.
//
//Please note that this is a simplified example and you might need to adjust it according to your specific needs. For instance, you might want to handle different MIME types, add error handling, or provide a way for the user to choose where to save the downloaded file1. Also, please make sure to test this on a real device, as file downloads might not work on the iOS simulator1.
