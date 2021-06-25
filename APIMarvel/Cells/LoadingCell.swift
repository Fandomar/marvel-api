//
//  LoadingCell.swift
//  APIMarvel
//
//  Created by admin on 23/6/21.
//

import UIKit

class LoadingCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
