//
//  WebViewController.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-25.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var url: NSURL!
    
    override func viewDidLoad() {
        self.webView.delegate = self
        var request = NSURLRequest(URL: url)
        self.webView.loadRequest(request)
    }
    
    @IBAction func closeTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareTapped(sender: UIBarButtonItem) {
        var activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        var title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.title = title
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.title = "Loading..."
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
