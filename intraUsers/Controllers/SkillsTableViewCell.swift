//
//  SkillsTableViewCell.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 24.10.18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
