//
//  BookPreviewCell.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/7/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import Foundation
import UIKit
class BookPreviewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  func selectedState(selected: Bool) {
    if selected {
      self.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
    } else {
      self.backgroundColor = UIColor.clear
    }
  }
  
}
