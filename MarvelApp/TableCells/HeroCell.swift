//
//  HeroCell.swift
//  MarvelApp
//
//  Created by admin on 6/22/21.
//

import UIKit
import Kingfisher

class HeroCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData (data: CharacterResult){
        heroName.text = data.name
        heroDescription.text = data.description  == "" ? "Not description found" : data.description
        
        guard let securePath = data.thumbnail?.path else { return }
        guard let secureExtension = data.thumbnail?.thumbExtension else { return }
        
        let secureURL = "\(securePath.replacingOccurrences(of: "http", with: "https")).\(secureExtension)"
        let url = URL(string: secureURL)
        
        heroImage.kf.setImage(with: url)
        
        //print("aaa \(https)")
        
    }
}
