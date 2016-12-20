//
//  Rate.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/4/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import Foundation

class Rate {
  var numOfRate: Int = 0
  var max: Int = 5
  var min: Int = 0
  var rate: Double = 0
  
  init?(JSON: [String:Any]?) {
    guard let max = JSON?["max"] as? Int, let min = JSON?["min"] as? Int, let avgStr = JSON?["average"] as? String, let avg = Double(avgStr), let numRaters = JSON?["numRaters"] as? Int else {
      return nil
    }
    self.numOfRate = numRaters
    self.max = max
    self.min = min
    self.rate = avg
  }
}
