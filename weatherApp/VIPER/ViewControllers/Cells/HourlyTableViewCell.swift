//
//  HourlyTableViewCell.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/27/21.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
