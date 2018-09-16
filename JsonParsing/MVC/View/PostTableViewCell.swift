//
//  PostTableViewCell.swift
//  JsonParsing
//
//  Created by Student 09 on 15/09/18.
//  Copyright © 2018 felix. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
