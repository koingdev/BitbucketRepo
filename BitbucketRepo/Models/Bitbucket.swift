//
//  Bitbucket.swift
//  BitbucketRepo
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Bitbucket {
    
    let displayName: String
    let type: String
    let avatarURL: String
    let createdDate: String
    
}

// MARK: - JSON
extension Bitbucket {
    
    static func parse(json: JSON) -> Bitbucket {
        let ownerJSON = json["owner"]
        let createdDate = json["created_on"].stringValue
        let displayName = ownerJSON["display_name"].stringValue
        let type = ownerJSON["type"].stringValue
        let avatarURL = ownerJSON["links"]["avatar"]["href"].stringValue
        return Bitbucket(displayName: displayName, type: type, avatarURL: avatarURL, createdDate: createdDate)
    }
    
}
