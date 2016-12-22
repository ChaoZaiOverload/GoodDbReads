//
//  SecondViewController.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/3/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController {
  var webView: WKWebView!
    
  var url: URL?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    webView = WKWebView(frame: self.view.frame)
    self.view.addSubview(webView)

  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if self.url == nil{
        
      let myURL = URL(string: "https://www.douban.com")
      let myRequest = URLRequest(url: myURL!)
      webView.load(myRequest)
      self.url = myURL
    }
  }
  
  public func loadPage(book: Book) {
    self.url = book.url
  }
}

