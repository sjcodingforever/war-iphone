//
//  CardTest.swift
//  war-iphoneTests
//
//  Created by Santosh Joseph on 5/29/20.
//  Copyright © 2020 Santosh Joseph. All rights reserved.
//

import XCTest

class CardTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
     func testCard() {
         let c1 = Card(rank: Rank.two, suit: Suit.club)
         XCTAssert(c1.toShortString() == "2C")
         XCTAssert(c1.toLongString() == "two of clubs")
     }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
