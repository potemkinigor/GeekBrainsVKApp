//
//  FriendsCollectionViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit


class FriendsPhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,  PassFriendInforamtionDelegate {
    
    @IBOutlet var photosCollectionView: UICollectionView!
    var friend: User!
    var delegate: SetOfImagesDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosCollectionView.register(UINib(nibName: "FriendsPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "friendPhotoReusableCell")
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self

    }
    
    func passedFriendData(_ friendPassed: User) {
        friend = friendPassed
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return friend.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoReusableCell", for: indexPath) as! FriendsPhotosCollectionViewCell
        
        cell.friendImage.image = friend.images[indexPath.row]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "imageViewer")
        viewcontroller.modalPresentationStyle = .fullScreen

        self.present(viewcontroller, animated: true, completion: nil)
        
        self.delegate = viewcontroller as? SetOfImagesDelegate
        
        delegate?.passedSetOfImages(friend.images)
        delegate?.passedNumberOfPickedImage(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let requiredWidth = 700
        let requiredHeight = 700
        
        return CGSize(width: requiredWidth, height: requiredHeight)
    }
    
}

protocol PassFriendInforamtionDelegate {
    func passedFriendData (_ friendPassed: User)
}
