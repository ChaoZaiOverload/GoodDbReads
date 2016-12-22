//
//  BookScrollViewWidget.swift
//  GoodDBReads
//
//  Created by Huiting Yu on 12/4/16.
//  Copyright © 2016 Huiting Yu. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

protocol BookScrollViewWidgetDelegate {
  func didSelectBook(book: Book)
}
class BookScrollViewWidget: UIView, UICollectionViewDelegate, UICollectionViewDataSource  {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var closeButton: UIButton!
  
  var books: [Book]? = nil
    
  var borderlayer = CALayer()
  
  var delegate: BookScrollViewWidgetDelegate?
  
  let bookCellId = "bookPreviewCellIdentifier"
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.collectionView.register(UINib(nibName: "BookPreviewCell", bundle: nil), forCellWithReuseIdentifier: bookCellId)
  
    self.layer.addSublayer(borderlayer)
  }
  

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func set(books: [Book]) {
    self.books = books
    self.collectionView.reloadData()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    borderlayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1)
    borderlayer.backgroundColor = UIColor.gray.cgColor
  }
  
  //data source
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.books?.count ?? 0
  }
  
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: BookPreviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellId, for: indexPath) as! BookPreviewCell
    let book = self.books![indexPath.row]
    cell.nameLabel.text = book.title
    if let rate = book.rate?.rate.description, let rateNum = book.rate?.numOfRate.description {
        cell.ratingLabel.text = "\(rate) / \(rateNum) rates"
    } else {
        cell.ratingLabel.text = "no ratings"
    }
    if let bookImg = book.smallImage {
      cell.imageView.image = bookImg
    } else {
      cell.imageView.image = UIImage(named: "book_placeholder")
      if let imageUrl = book.smallImageUrl {
        let imageManager = SDWebImageManager.shared()
        let _ = imageManager?.downloadImage(with: imageUrl, options: [] , progress: { (retrievedSize, expectedSize) in
          
        }, completed: { (image, error, cacheType, isFinished, url) in
          if let image = image {
            cell.imageView.image = image
          }
        })
      }
    }
    return cell
  }
  
  //delegate
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let book = self.books![indexPath.row]
    self.delegate?.didSelectBook(book: book)
  }
  
  @IBAction func closeButtonTapped(sender: UIButton) {
    
  }
  
  
}
