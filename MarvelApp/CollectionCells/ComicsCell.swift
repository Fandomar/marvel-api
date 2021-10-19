//
//  PortadasCell.swift
//  MarvelApp
//
//  Created by admin on 6/24/21.
//

import UIKit
import Kingfisher

class ComicsCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePortada: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code}
    }
    
    func setComic(data: ComicResult){
        guard let securePath = data.thumbnail?.path else { return }
        guard let secureExtension = data.thumbnail?.imageExtension else { return }
        
        let secureURL = "\(securePath.replacingOccurrences(of: "http", with: "https")).\(secureExtension)"
        let url = URL(string: secureURL)
        
        imagePortada.kf.setImage(with: url)
    }
    
    
}
