//
//  BitbucketTableViewCell.swift
//  BitbucketRepo
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import UIKit
import Kingfisher

class BitbucketTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var displayNameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var createDateLabel: UILabel!
    
    func configure(bitbucket: Bitbucket) {
        displayNameLabel.text = bitbucket.displayName
        typeLabel.text = bitbucket.type
        createDateLabel.text = bitbucket.createdDate
        avatarImageView.kf.setImage(with: URL(string: bitbucket.avatarURL))
    }
    
}
