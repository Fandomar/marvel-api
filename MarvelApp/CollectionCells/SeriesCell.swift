//
//  SeriesCell.swift
//  MarvelApp
//
//  Created by admin on 6/29/21.
//

import UIKit

class SeriesCell: UICollectionViewCell {
    
    @IBOutlet weak var imageSeries: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setSeries(data: SeriesResult){
        
        guard let securePath = data.thumbnail?.path else { return }
        guard let secureExtension = data.thumbnail?.imageExtension else { return }
        
        let secureURL = "\(securePath.replacingOccurrences(of: "http", with: "https")).\(secureExtension)"
        let url = URL(string: secureURL)
        
        //print("\(url)")
        imageSeries.kf.setImage(with: url)
    }
    
}
