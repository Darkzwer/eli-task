//
//  CollectionVC.swift
//  eli task
//
//  Created by Igor on 15/09/2021.
//  Copyright © 2021 DSoft. All rights reserved.
//

import UIKit

class CollectionVC: UICollectionViewController {
    
    // MARK: - Public API, Model
    private var imageCollection = [ImageModel]()
    
    // MARK: Add Button
    @IBAction private func addAction(_ sender: UIBarButtonItem) {
        imageDownload(n: 1)
    }
    
    // MARK: Refresh Button
    @IBAction private func refreshAction(_ sender: UIBarButtonItem) {
        imageCollection.removeAll()
        imageDownload(n: 140)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Funny Cats & Girls"
        layoutSetup()
        imageDownload(n: 279)
    }
    
    func imageDownload(n: Int) {
        var i = 0
        repeat {
            i+=1
            let lastIndexPath = IndexPath(item: imageCollection.count, section: 0)
            imageCollection.append(contentsOf: Constants.imagesOfCats)
            collectionView.insertItems(at: [lastIndexPath])
        } while i < n
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        if let imageCell = cell as? CellVC {
            let images = imageCollection[indexPath.item]
                DispatchQueue.main.async {
                    if imageCell.imageURL == nil, imageCell.imageURL != images.url {
                    imageCell.imageURL = images.url
                }
            }
        }
        return cell
    }
    
    // MARK: UICollectionViewLayout
    private func layoutSetup() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumLineSpacing = 2.0
//        layout.minimumInteritemSpacing = 2.0
//        layout.sectionInset = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        layout.scrollDirection = .vertical
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
}

//extension CollectionVC: UICollectionViewDelegateFlowLayout {

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemsPerRow: CGFloat = 2
//        let paddingWidht = 20 * (itemsPerRow + 1)
//        let availableWidth = collectionView.frame.width - paddingWidht
//        let widthPerItem = availableWidth / itemsPerRow
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//}
