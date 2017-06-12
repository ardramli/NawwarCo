//
//  ItemsTableViewCell.swift
//  NawwarCo
//
//  Created by ardMac on 13/06/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemColorLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!

    static let cellIdentifier = "ItemsTableViewCell"
    static let cellNib = UINib(nibName: ItemsTableViewCell.cellIdentifier, bundle: Bundle.main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
