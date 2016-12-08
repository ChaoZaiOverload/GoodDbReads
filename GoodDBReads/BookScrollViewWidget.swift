//
//  BookScrollViewWidget.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/4/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import Foundation
import UIKit

class BookScrollViewWidget: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
  var collectionView: UICollectionView = UICollectionView()
  var closeButton: UIButton = UIButton(type: UIButtonType.custom)
  
  var books: [Book]? = nil
  
  
  init() {
    super.init(frame: CGRect.zero)
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(books: [Book]) {
    self.books = books
    self.setNeedsLayout()
  }
  
  //data source
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.books?.count ?? 0
  }
  
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
  }
  
  
}
