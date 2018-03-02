//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    var seasonOne: Season!
    var episodeOne: Episode!
    
    override func setUp() {
        super.setUp()
        seasonOne = Season(name: "SeasonOne", releaseDate: Date(dateString: "2000-01-01"), firstEpisodeTitle: "First episode")
        episodeOne = Episode(title: "First episode", issueDate: Date(dateString: "2000-01-01"), season: seasonOne)
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func testSeasonExistence() {
        XCTAssertNotNil(seasonOne)
    }
    
    func testSeasonContainsAtLeastOneEpisode() {
        XCTAssertGreaterThanOrEqual(seasonOne.episodeCount, 1)
    }
    
    func testAddEpisodyWithoutPreviousSeason() {
        XCTAssertEqual(seasonOne.episodeCount, 1)

        let episodeTwo = Episode(title: "Second episode", issueDate: Date(dateString: "2000-01-08"), season: nil)
        seasonOne.add(episode: episodeTwo)
        
        XCTAssertEqual(seasonOne.episodeCount, 2)
    }
    
    func testAddEpisodesOneByOne() {
        XCTAssertEqual(seasonOne.episodeCount, 1)
        
        seasonOne.add(episode: episodeOne)
        XCTAssertEqual(seasonOne.episodeCount, 1)
        
        let episodeTwo = Episode(title: "Second episode", issueDate: Date(dateString: "2000-01-08"), season: seasonOne)
        seasonOne.add(episode: episodeTwo)
        XCTAssertEqual(seasonOne.episodeCount, 2)
    }
    
    func testAddEpisodesInOneCall() {
        XCTAssertEqual(seasonOne.episodeCount, 1)
        
        let episodeTwo = Episode(title: "Second episode", issueDate: Date(dateString: "2000-01-08"), season: seasonOne)

        seasonOne.add(episodes: episodeOne, episodeTwo, episodeTwo, episodeOne)
        XCTAssertEqual(seasonOne.episodeCount, 2)
    }
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(seasonOne, seasonOne)
        
        // Igualdad
        let seasonOneRepeated = Season(name: "SeasonOne", releaseDate: Date(dateString: "2000-01-01"), firstEpisodeTitle: "First episode")
        XCTAssertEqual(seasonOne, seasonOneRepeated)
        
        // Desigualdad
        let seasonTwo = Season(name: "SeasonTwo", releaseDate: Date(dateString: "2000-02-01"), firstEpisodeTitle: "First episode")
        XCTAssertNotEqual(seasonOne, seasonTwo)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(seasonOne.hashValue)
    }
    
    func testSeasonComparison() {
        let seasonZero = Season(name: "SeasonZero", releaseDate: Date(dateString: "1999-12-01"), firstEpisodeTitle: "First episode")

        XCTAssertLessThan(seasonZero, seasonOne)
    }
    
    func testSeasonReturnsSortedArrayOfEpisodes() {
        let episodeTwo = Episode(title: "Second episode", issueDate: Date(dateString: "2000-01-08"), season: seasonOne)

        XCTAssertEqual(seasonOne.sortedEpisodes, [episodeOne, episodeTwo])
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertEqual(seasonOne.description, "(Season: \(seasonOne.name), relase date: \(seasonOne.releaseDate.stringDate()), with: \(seasonOne.episodeCount) episodes")
    }
}
