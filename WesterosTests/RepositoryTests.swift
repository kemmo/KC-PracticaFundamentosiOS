//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Jorge Vinaches on 13/02/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!
    var localSeasons: [Season]!
    
    override func setUp() {
        super.setUp()
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsHouseByCaseInsensitively() {
        let stark = Repository.local.house(named: "sTarK")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryReturnsHouseBySafeName() {
        let stark = Repository.local.house(safeNamed: .stark)
        XCTAssertEqual(stark?.name, "Stark")
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        XCTAssertEqual(filtered.count, 1)
        
        let otherFilter = Repository.local.houses(filteredBy: { $0.words.contains("invierno")})
        XCTAssertEqual(otherFilter.count, 1)
    }
    
    func testLocalRepositorySeasonsCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }
    
    func testLocalRepositoryReturnsSeasonByCaseInsensitively() {
        let seasonThree = Repository.local.season(named: "Season 3")
        XCTAssertEqual(seasonThree?.name, "Season 3")
        
        let seasonNine = Repository.local.season(named: "Season 9")
        XCTAssertNil(seasonNine)
    }
    
    func testSeasonFiltering() {
        let filtered = Repository.local.seasons(filteredBy: { $0.episodeCount == 4 })
        XCTAssertEqual(filtered.count, 1)
        
        let otherFilter = Repository.local.seasons(filteredBy: { $0.releaseDate.stringDate().contains("2016") })
        XCTAssertEqual(otherFilter.count, 1)
    }
    
}
