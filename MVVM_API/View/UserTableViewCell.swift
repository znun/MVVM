//
//  UserTableViewCell.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 2/10/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func configure(with user: UserModel) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        addressLabel.text = user.address
    }
}
