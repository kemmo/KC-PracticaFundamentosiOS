//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Jorge Vinaches on 08/02/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    
    override func setUp() {
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "León rampante")
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse, wikiUrl: URL(string: "https://es.wikipedia.org/wiki/Robb_Stark")!)
        arya = Person(name: "Arya", house: starkHouse, wikiUrl: URL(string: "https://es.wikipedia.org/wiki/Arya_Stark")!)
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse, wikiUrl:  URL(string: "https://es.wikipedia.org/wiki/Tyrion_Lannister")!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testAddPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)

        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
        
        let cersei = Person(name: "Cersei", house: lannisterHouse, wikiUrl:  URL(string: "https://es.wikipedia.org/wiki/Cersei_Lannister")!)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse, wikiUrl:  URL(string: "https://es.wikipedia.org/wiki/Jaime_Lannister")!)
        
        lannisterHouse.add(persons: cersei, jaime, jaime, jaime, jaime, arya, robb)
        XCTAssertEqual(lannisterHouse.count, 2)
    }
    
    func testHouseEquality() {
        // Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Igualdad
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        XCTAssertEqual(jinxed, starkHouse)
        
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouseReturnsSortedArrayOfMembers() {
        starkHouse.add(persons: robb, arya)
        
        XCTAssertEqual(starkHouse.sortedMembers, [arya, robb])
    }
}
