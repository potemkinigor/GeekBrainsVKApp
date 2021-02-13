//
//  NewsCollectionViewCell.swift
//  VKApp
//
//  Created by User on 11.02.2021.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var newsLikes: LikeControlButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var repostsCount: UILabel!
    @IBOutlet weak var viewsCount: UILabel!
    
    var mediaDataArray: [UIImage] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mediaCollectionView.delegate = self
        self.mediaCollectionView.dataSource = self
        self.mediaCollectionView.isScrollEnabled = false
         
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
                
        self.layer.cornerRadius = 5
        
        newsLikes.addTarget(self, action: #selector(updateView), for: .valueChanged)
        
        mediaCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageReusableIdentifyer")
    }
    
    @objc func updateView () {
        likesCount.text = "\(news[newsLikes.newsIndex].likesCount)"
    }

}

extension NewsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "imageReusableIdentifyer", for: indexPath) as! ImageCollectionViewCell
        
        cell.image.image = mediaDataArray[indexPath.row]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var requiredWidth = 0
        var requiredHeight = 0
        
        let numberOfRows = (mediaDataArray.count + 1) / 2
        
        if mediaDataArray.count == 1 {
            requiredWidth = Int(collectionView.frame.width)
            requiredHeight = Int(collectionView.frame.height)
        } else if mediaDataArray.count % 2 == 0 {
            requiredWidth = Int(Float(collectionView.frame.width) / Float(2)) - 1
            requiredHeight = Int(Float(collectionView.frame.height) / Float(mediaDataArray.count / 2)) - 1
        } else {
            requiredWidth = Int(Float(collectionView.frame.width) / Float(2)) - 1
            requiredHeight = Int(Float(collectionView.frame.height) / Float(numberOfRows)) - 1
            
            if indexPath.row == mediaDataArray.count - 1 && indexPath.row != 0 {
                requiredWidth = Int(collectionView.frame.width)
            }
        }
        
        
        
        return CGSize(width: requiredWidth, height: requiredHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
}
