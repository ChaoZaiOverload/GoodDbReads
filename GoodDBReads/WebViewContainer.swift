//
//  WebViewContainer.swift
//  GoodDBReads
//
//  Created by apple on 21/12/2016.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import Foundation
import UIKit
import WebKit
protocol WebViewContainerDelegate: WKNavigationDelegate {
  
}

class WebViewContainer: UIView  {
  var webView = WKWebView()
  
  private var _delegate: WebViewContainerDelegate?
  var delegate : WebViewContainerDelegate? {
    get {
      return _delegate
    }
    set {
      _delegate = newValue
      self.webView.navigationDelegate = _delegate
    }
  }
  
  override var frame: CGRect {
    get {
      return super.frame
    }
    set {
      super.frame = frame
    
      webView.frame.origin = CGPoint(x: 0, y: 0)
      webView.frame.size = self.frame.size
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.addSubview(webView)
    
    self.backgroundColor = UIColor.clear

    webView.frame.origin = CGPoint(x: 0, y: 0)
    webView.frame.size = self.frame.size
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    webView.frame.origin = CGPoint(x: 0, y: 0)
    webView.frame.size = self.frame.size
  }
  
  func load(url: URL?) {
    if let url = url {
      let myRequest = URLRequest(url: url)
      webView.load(myRequest)
    }
  }
  
}
