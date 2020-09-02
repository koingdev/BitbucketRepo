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
        typeLabel.text = "Type: \(bitbucket.type)"
        createDateLabel.text = "Created: \(formattedDate(bitbucket.createdDate))"
        avatarImageView.kf.setImage(with: URL(string: bitbucket.avatarURL))
    }
    
    private func formattedDate(_ date: String) -> String {
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = df.date(from: date) else { return "" }
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: date)
    }
    
}
