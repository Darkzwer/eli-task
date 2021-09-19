//
//  CollectionVC.swift
//  eli task
//
//  Created by Igor on 15/09/2021.
//  Copyright © 2021 DSoft. All rights reserved.
//

import UIKit

class CollectionVC: UICollectionViewController {
    
    //var urlcheck = imageCell.imageURL
    
    // MARK: - Public API, Model
    private var imageCollection = [ImageModel]()
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    // MARK: Add Button
    @IBAction private func addAction(_ sender: UIBarButtonItem) {
        imageDownload()
    }
    
    // MARK: Refresh Button
    @IBAction private func refreshAction(_ sender: UIBarButtonItem) {
        imageCollection.removeAll()
        //let images = [ImageModel(url: URL(string: Constants.url)!)]
        var i = 0
        repeat {
            i+=1
            imageDownload()
        } while i < 140
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Funny Cats & Girls"
        layoutSetup()
        var i = 0
        repeat {
            i+=1
            imageDownload()
        } while i < 140
    }
    
    func imageDownload() {
        let lastIndexPath = IndexPath(item: imageCollection.count, section: 0)
        imageCollection.append(contentsOf: Constants.imagesOfCats)
        collectionView.insertItems(at: [lastIndexPath])
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .systemYellow
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentMode = .scaleAspectFill
        collectionView.layer.cornerRadius = 7
        collectionView.clipsToBounds = true
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
