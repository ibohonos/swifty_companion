//
//  UserInfoTableViewCell.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 10/15/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var ava: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var wallets: UILabel!
    @IBOutlet weak var corrections: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var levelBar: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
