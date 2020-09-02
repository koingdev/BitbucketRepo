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
        guard let path = Bundle.main.path(forResource: "Mock", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            XCTFail("Could not find Mock json file!")
            return
        }
        
        // When
        let json = JSON(data)
        let bitbucket = Bitbucket.parse(json: json)
        
        // Then
        XCTAssertEqual(bitbucket.name, "Design Pattern", "Name should be Design Pattern!")
        XCTAssertEqual(bitbucket.description, "test_description", "Description should be test_description!")
        XCTAssertEqual(bitbucket.type, "repository", "Type should be repository!")
        XCTAssertEqual(bitbucket.size, 100, "Size should be 100!")
        XCTAssertEqual(bitbucket.website, "test_web_site", "Website should be test_web_site!")
        XCTAssertEqual(bitbucket.language, "Swift", "Language should be Swift!")
        XCTAssertEqual(bitbucket.ownerDisplayName, "KoingDev", "Display name should be KoingDev!")
        XCTAssertEqual(bitbucket.ownerType, "user", "Type should be user!")
        XCTAssertEqual(bitbucket.ownerAvatarURL, "test_avatar_url", "Avatar url should be test_avatar_url!")
        XCTAssertEqual(bitbucket.createdDate, "2020-09-02", "Create date should be 2020-09-02!")
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
        XCTAssertTrue(bitbucket.name.isEmpty, "Name should be empty!")
        XCTAssertTrue(bitbucket.description.isEmpty, "Description should be empty!")
        XCTAssertTrue(bitbucket.type.isEmpty, "Type should be empty!")
        XCTAssertTrue(bitbucket.size == 0, "Type should be 0!")
        XCTAssertTrue(bitbucket.website.isEmpty, "Website should be empty!")
        XCTAssertTrue(bitbucket.language.isEmpty, "Language should be empty!")
        XCTAssertTrue(bitbucket.ownerDisplayName.isEmpty, "Display name should be empty!")
        XCTAssertTrue(bitbucket.ownerType.isEmpty, "Type should be empty!")
        XCTAssertTrue(bitbucket.ownerAvatarURL.isEmpty, "Avatar url should be empty!")
        XCTAssertTrue(bitbucket.createdDate.isEmpty, "Create date should be empty!")
    }

}
