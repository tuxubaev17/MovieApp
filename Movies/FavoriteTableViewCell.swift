//
//  FavoriteTableViewCell.swift
//  Movies
//
//  Created by Alikhan Tuxubayev on 17.02.2021.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
