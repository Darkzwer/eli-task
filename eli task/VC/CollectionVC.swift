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
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Funny Cats & Girls"
        layoutSetup()
        imageDownload(n: 1300)
    }
    
    func imageDownload(n: Int) {
        var i = 0
        repeat {
            i+=1
            let lastIndexPath = IndexPath(item: imageCollection.count-1, section: 0)
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
            imageCell.layer.cornerRadius = 7
            //imageCell.backgroundColor = .black
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
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemBackground
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension CollectionVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 7
        let itemPerSection: CGFloat = 12
        let paddingWidth = 2 * (itemsPerRow + 1)
        let paddingHeight = 2 * (itemPerSection + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let availableHeidht = collectionView.frame.height - paddingHeight
        let widthPerItem = availableWidth / itemsPerRow
        let heidhtPerSection = availableHeidht / itemPerSection
        return CGSize(width: widthPerItem, height: heidhtPerSection)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
}
