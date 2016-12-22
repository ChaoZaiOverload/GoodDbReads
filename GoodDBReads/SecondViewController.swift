//
//  SecondViewController.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/3/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import UIKit
import WebKit
import Foundation

class SecondViewController: UIViewController {
  private var webView: WKWebView!
    
  private var url: URL? {
    didSet {
      //self.needsReload = true
    }
  }

  private var needsReload: Bool = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    webView = WKWebView(frame: self.view.frame)
    self.view.addSubview(webView)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if self.url == nil{
      let myURL = URL(string: "https://www.douban.com")

      self.url = myURL

      let myRequest = URLRequest(url: myURL!)
      webView.load(myRequest)
      
      self.needsReload = false
    } else if self.needsReload {
      webView.load(URLRequest(url: self.url!))
      self.needsReload = false
    }
  }
  
  public func loadPage(book: Book) {
    self.url = book.url
    if let url = book.url {
      webView.load(URLRequest(url: url))
    }
  }
}

