//
//  BitbucketTests.swift
//  BitbucketTests
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import BitbucketRepo

class BitbucketTests: XCTestCase {
    
    func testParseValidJSON() {
        // Given
        let mock = """
        {
          "created_on": "2020/09/02",
          "owner": {
            "display_name": "test_name",
            "links": {
              "avatar": {
                "href": "test_url"
              }
            },
            "type": "user"
          }
        }
        """
        
        // When
        let json = JSON(parseJSON: mock)
        let bitbucket = Bitbucket.parse(json: json)
        
        // Then
        XCTAssertEqual(bitbucket.displayName, "test_name", "Display name should be test_name!")
        XCTAssertEqual(bitbucket.type, "user", "Type should be user!")
        XCTAssertEqual(bitbucket.avatarURL, "test_url", "Avatar url should be test_url!")
        XCTAssertEqual(bitbucket.createdDate, "2020/09/02", "Create date should be 2020/09/02!")
    }

    func testParseEmptyJSON() {
        // Given
        let mock = """
        {

        }
        """
        
        // When
        let json = JSON(parseJSON: mock)
        let bitbucket = Bitbucket.parse(json: json)
        
        // Then
        XCTAssertTrue(bitbucket.displayName.isEmpty, "Display name should be empty!")
        XCTAssertTrue(bitbucket.type.isEmpty, "Type should be empty!")
        XCTAssertTrue(bitbucket.avatarURL.isEmpty, "Avatar url should be empty!")
        XCTAssertTrue(bitbucket.createdDate.isEmpty, "Create date should be empty!")
    }

}
