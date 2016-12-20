//
//  FirstViewController.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/3/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
import SWXMLHash

class FirstViewController: UIViewController, WKNavigationDelegate, BookScrollViewWidgetDelegate {

  var webView: WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    webView = WKWebView(frame: self.view.frame)
    webView.navigationDelegate = self
    self.view.addSubview(webView)

    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    let myURL = URL(string: "https://www.goodreads.com")
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
  }
  
  public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
    
    defer {
      decisionHandler(.allow)
    }
    
    guard let url = navigationAction.request.url?.absoluteString else {
      return
    }
    
    guard let r =  url.range(of: "goodreads.com/book/show/") else {
      return
    }
    
    let startIndDist = url.distance(from: url.startIndex, to: r.upperBound)
    guard startIndDist < url.characters.count else {
      return
    }
    
    let urlSubStr = url.substring(from: url.index(url.startIndex, offsetBy: startIndDist))
    guard let idStr = urlSubStr.components(separatedBy: NSCharacterSet.alphanumerics.inverted).first else {
      return
    }
    
    print("idstr=\(idStr)")
    
    
    getBookFromGoodreads(bookId: idStr)
    
    
    /*
    if(navigationAction.request.url?.absoluteString.contains())! {
      
      
    }*/
  }
  public func didSelectBook(book: Book) {
    if let svc = self.tabBarController?.viewControllers?[0] as? SecondViewController {
      svc.loadPage(book: book)
    }
  }
  
  private func getBookFromGoodreads(bookId: String) {
    guard let url = URL(string: "https://www.goodreads.com/book/show/\(bookId)?") else {
      return
    }
    Alamofire.request(url,
                      method: .get,
                      parameters: ["key": "4HkQsgQpk1VhSlhMK56Few"],
                      encoding: URLEncoding.default,
                      headers: nil)
      .response { [unowned self] (response) in
        if let data = response.data {
          let xml = SWXMLHash.parse(data)
          
          let title = xml["GoodreadsResponse"]["book"]["title"].element!.text!
          let author = xml["GoodreadsResponse"]["book"]["authors"]["author"][0]["name"].element!.text!
          
          
          print("title= \(title), author=\(author)")
          
          self.searchDoubanWithKeyword("\(title) \(author)")
        }
      }
  }
  
  private func searchDoubanWithKeyword(_ keyword: String) {
    let url = URL(string: "https://api.douban.com/v2/book/search?")!
    
    Alamofire.request(url,
                      method: .get,
                      parameters: ["q": "\(keyword)",
                                  "count": 10],
                      encoding: URLEncoding.default,
                      headers: nil)
    .responseJSON { [unowned self] (response) in
      
      var searchResults : [Book] = []


      if let JSON = response.result.value as? NSDictionary,
      let books = JSON["books"] as? [[String:Any]] {
        for bookJSON in books {
          if let book = Book(JSON: bookJSON) {
            searchResults.append(book)
          }
        }
      }
      
      self.showBooksInScrollView(books: searchResults)
      
    }
    
    
  }

  private func showBooksInScrollView(books: [Book]) {
    let widget = Bundle.main.loadNibNamed("BookScrollViewWidget", owner: nil, options: nil)?[0] as! BookScrollViewWidget
    widget.set(books: books)
    let bottomBarOffset = self.bottomLayoutGuide.length + 2
    widget.frame.origin = CGPoint(x: 0, y: self.view.frame.height-bottomBarOffset-widget.frame.size.height)
    self.view.addSubview(widget)
  }

}

