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
        imageCollection.append(contentsOf: Constants.imagesOfCats)
        //Get last index
        let arrayOfVisibleItems = collectionView.indexPathsForVisibleItems.sorted()
        let lastIndexPath = arrayOfVisibleItems.last
        print("Array: ", arrayOfVisibleItems)
        print("Last IndexPath: ", lastIndexPath)
        //        let indexPath = IndexPath(item: lastItem, section: lastSection)
        //        collectionView.reloadItems(at: [indexPath])
        //        collectionView.reloadSections(at: [indexPath])
    }
    
    // MARK: Refresh Button
    @IBAction private func refreshAction(_ sender: UIBarButtonItem) {
        imageCollection.removeAll()
        var i = 0
        repeat {
            i+=1
            imageCollection.append(contentsOf: Constants.imagesOfCats)
            collectionView.reloadData()
        } while i < 140
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Funny Cats & Girls"
        imageDownload()
        layoutSetup()
    }
    
    func imageDownload() {
        var i = 0
        repeat {
            i+=1
            imageCollection.append(contentsOf: Constants.imagesOfCats)
            collectionView.reloadData()
        } while i < 200
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        
        if let imageCell = cell as? CellVC {
            let images = imageCollection[indexPath.item]
            imageCell.imageURL = images.url
        }
        return cell
    }
    
    // MARK: UICollectionViewLayout
    
    private func layoutSetup() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 2, height: 2)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension UICollectionView {
    func scrollToLastCell(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfItems(inSection: lastSectionIndex) - 1 // last item
        let indexPath = IndexPath(item: lastRowIndex, section: lastSectionIndex)
        print(indexPath)
        //collectionView.reloadItems(at: [indexPath])
    }
}
