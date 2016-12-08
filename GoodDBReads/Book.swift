//
//  Book.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/4/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import Foundation
import UIKit

class Book {
  var title: String = ""
  var author: String = ""
  var smallImageUrl: URL? = nil
  var smallImage: UIImage? = nil
  
  var rate: Rate? = nil
  
  var url: URL? = nil
  
  init?(JSON: [String:Any]?) {
    guard let jtitle = JSON?["title"] as? String,
          let jAuthor = (JSON?["author"] as? [String])?[0],
    let jImgUrl = (JSON?["images"] as? [String: Any])?["small"] as? URL,
    let jRate = Rate(JSON: JSON?["rating"] as? [String : Any]),
      let jURL = JSON?["url"] as? URL else {
        return nil
    }
    self.title = jtitle
    self.author = jAuthor
    self.smallImageUrl = jImgUrl
    self.rate = jRate
    self.url = jURL
  }

}
