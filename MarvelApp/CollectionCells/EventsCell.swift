//
//  EventsCell.swift
//  MarvelApp
//
//  Created by admin on 6/29/21.
//

import UIKit

class EventsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageEvent: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setEvent(data: EventResult){
        
        guard let securePath = data.thumbnail?.path else { return }
        guard let secureExtension = data.thumbnail?.imageExtension else { return }
        
        let secureURL = "\(securePath.replacingOccurrences(of: "http", with: "https")).\(secureExtension)"
        let url = URL(string: secureURL)
        
        imageEvent.kf.setImage(with: url)
    }
    
}
