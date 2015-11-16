//
//  ViewController.swift
//  webview2
//
//  Created by Michael Tran on 10/11/2015.
//  Copyright © 2015 intcloud. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self; // this line is to link with the UIWebViewDelegate protocol for bridging purpose.  - line 1
        webview.scrollView.bounces = false; // block your webview from bouncing so it works as an app. - line 2
        let localfilePath = NSBundle.mainBundle().URLForResource("index1.html", withExtension: "", subdirectory: "www"); // load file index.html in www - line 3
        let request = NSURLRequest(URL: localfilePath!); // get the request to the file - line 4
        //let request = NSURLRequest(URL: NSURL(string:"http://www.google.com")!);
        webview.loadRequest(request); // load it on the webview - line 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// Callback when the webpage is finished loading
    func webViewDidFinishLoad(web: UIWebView){
// looking for the current URL
        let currentURL = web.request?.URL?.absoluteString;
        print("html content loaded! " + currentURL!);
        
    }
    
// this is the main function to trap JS call via document.location either by click or js function call
    func webView(webView: UIWebView,
        shouldStartLoadWithRequest request: NSURLRequest,
        navigationType nType: UIWebViewNavigationType) -> Bool {
            
//the request.URL?.scheme is the first part of the document.location before the first ':'. It is originally http, or https, or file.  in JS can be anything predefined ie aaa bbb, in this case we use 'bridge:'
            print("scheme is : " + request.URL!.scheme);
            
            if (request.URL?.scheme == bridge_theme)
            {
                myrecord = process_scheme((request.URL?.absoluteString)!);
                switch myrecord.function {
                case "ios_alert":alert("Bridging" , message: myrecord.param);
                default : print("dont know function name: \(myrecord.function)")
                }

                return false;
            }
            return true;

    }
}
