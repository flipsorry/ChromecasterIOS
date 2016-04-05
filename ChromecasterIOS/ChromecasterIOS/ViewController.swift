//
//  ViewController.swift
//  ChromecasterIOS
//
//  Created by Dinh, Liem on 4/4/16.
//  Copyright © 2016 Dinh, Liem. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    @IBOutlet var containerView : UIView! = nil
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        var contentController = WKUserContentController();
        var userScript = WKUserScript(
            source: "redHeader()",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: self.containerView.bounds,
            configuration: config
        )
        self.view = self.webView!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL(string:"http://drakestears.com/v1/home.php")
        var req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
    }
    
    func userContentController(userContentController: WKUserContentController!, didReceiveScriptMessage message: WKScriptMessage!) {
        if(message.name == "callbackHandler") {
            print("JavaScript is sending a message \(message.body)")
            webView!.evaluateJavaScript("setChromecasts(\(1 + 1))", completionHandler: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

