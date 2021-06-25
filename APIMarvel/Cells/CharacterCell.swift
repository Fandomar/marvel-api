//
//  CharacterCell.swift
//  APIMarvel
//
//  Created by admin on 22/6/21.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setData(character: CharacterResult) {
        guard let secureImagePath = character.thumbnail?.path else { return }
        
        guard let secureImageExtension = character.thumbnail?.thumbExtension else { return }
        
        let url = URL(string: "\(secureImagePath.replacingOccurrences(of: "http", with: "https")).\(secureImageExtension)")
        guard let secureURL = url else { return }
        
        
        
        print("URL = \(secureURL)")
        
        characterName.text = character.name
        
        characterDescription.text = character.description == "" ? "Not description found" : character.description
        
        characterImage.kf.setImage(with: secureURL)
        
        characterImage.layer.cornerRadius = 8
    }
    
}
