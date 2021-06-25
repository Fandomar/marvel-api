//
//  ComicCVCell.swift
//  APIMarvel
//
//  Created by admin on 24/6/21.
//

import UIKit
import Kingfisher

class ComicCVCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var comicImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(comic: Comics) {
        guard let secureURL = comic.collectionURI else { return }
        
        let url = URL(string: secureURL)
        
        comicImage.kf.setImage(with: url)
    }
    
}
