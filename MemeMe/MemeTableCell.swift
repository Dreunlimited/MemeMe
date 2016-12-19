//
//  MemeTableCell.swift
//  MemeMe
//
//  Created by Dandre Ealy on 12/12/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit

class MemeTableCell: UITableViewCell {

    @IBOutlet weak var memeTextLabel: UILabel!
    @IBOutlet weak var memeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
