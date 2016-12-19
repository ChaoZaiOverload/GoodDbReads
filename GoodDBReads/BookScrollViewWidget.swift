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
  
  var delegate: BookScrollViewWidgetDelegate?
  
  let bookCellId = "bookPreviewCellIdentifier"
  override func awakeFromNib() {
    super.awakeFromNib()
    self.collectionView.register(UINib(nibName: "BookPreviewCell", bundle: nil), forCellWithReuseIdentifier: bookCellId)
  }
  

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func set(books: [Book]) {
    self.books = books
    self.setNeedsLayout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
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
    cell.ratingLabel.text = "\(book.rate?.rate) // from \(book.rate?.numOfRate)"
    if let bookImg = book.smallImage {
      cell.imageView.image = bookImg
    } else {
      cell.imageView.image = UIImage(named: "book_placeholder")
      if let imageUrl = book.smallImageUrl {
        let imageManager = SDWebImageManager.shared()
        imageManager?.downloadImage(with: imageUrl, options: [] , progress: { (retrievedSize, expectedSize) in
          
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
