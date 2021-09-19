//
//  CellVC.swift
//  eli task
//
//  Created by Igor on 15/09/2021.
//  Copyright © 2021 DSoft. All rights reserved.
//

import UIKit

class CellVC: UICollectionViewCell {
    
    @IBOutlet weak var imageGallery: UIImageView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSetup()
    }
    
    // MARK: - Public API
    var imageURL: URL? {
        didSet { updateUI()}
    }
    
    private func updateUI() {//dont work if we check image set
        if let url = imageURL{
            spinner?.startAnimating()
            imageGallery.image = nil
            DispatchQueue.global(qos: .userInitiated).async {
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents,
                        url == self.imageURL,
                        let image = UIImage(data: imageData) {
                        self.imageGallery?.image = image
                    }
                    self.spinner?.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - ImageSetup
    private func imageSetup() {
        imageGallery.contentMode = .scaleAspectFill
        imageGallery.layer.cornerRadius = 7
        imageGallery.clipsToBounds = true
    }
    
}
