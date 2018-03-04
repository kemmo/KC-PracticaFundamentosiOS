//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    var seasonOne: Season!
    var episodeOne: Episode!
    var episodeTwo: Episode!
    
    override func setUp() {
        super.setUp()
        episodeOne = Episode(title: "First episode", issueDate: Date(dateString: "2000-01-01"), summary: "", season: nil)
        seasonOne = Season(name: "SeasonOne", releaseDate: Date(dateString: "2000-01-01"), firstEpisode: episodeOne)
        episodeTwo = Episode(title: "Second episode", issueDate: Date(dateString: "2000-01-08"), summary: "", season: seasonOne)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddEpisodeToSeasonByCreatingEpisode() {
        XCTAssertEqual(seasonOne.episodeCount, 2)
        
        let _ = Episode(title: "Third episode", issueDate: Date(dateString: "2000-01-15"), summary: "", season: seasonOne)
        XCTAssertEqual(seasonOne.episodeCount, 3)
    }
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(episodeOne, episodeOne)
        
        // Igualdad
        let episodeOneRepeated = Episode(title: "First episode", issueDate: Date(dateString: "2000-01-01"), summary: "", season: seasonOne)
        XCTAssertEqual(episodeOne, episodeOneRepeated)
        
        // Desigualdad
        XCTAssertNotEqual(episodeOne, episodeTwo)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(episodeOne.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(episodeOne, episodeTwo)
    }
    
    func testEpisodeCustomStringConvertible() {
        XCTAssertEqual(episodeOne.description, "Episode: \(episodeOne.title), issue date: \(episodeOne.issueDate.stringDate), of season: \(episodeOne.season?.name ?? "Unknown")")
    }
}
