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
          let jAuthor = (JSON?["author"] as? [String])?.first,
    let jImgUrlStr = (JSON?["images"] as? [String: Any])?["small"] as? String,
      let jImgUrl = URL(string: jImgUrlStr),
    let jRate = Rate(JSON: JSON?["rating"] as? [String : Any]),
      let jURLStr = JSON?["url"] as? String,
      let jURL = URL(string: jURLStr)
      else {
        return nil
    }
    self.title = jtitle
    self.author = jAuthor
    self.smallImageUrl = jImgUrl
    self.rate = jRate
    self.url = jURL
  }

}
