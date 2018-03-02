//
//  Repository.swift
//  Westeros
//
//  Created by Jorge Vinaches on 13/02/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    typealias SeasonFilter = (Season) -> Bool
    
    var houses: [House] { get }
    func house(named: String) -> House?
    func houses(filteredBy: HouseFilter) -> [House]
}

protocol SeasonFactory {
    var seasons: [Season] { get }
    func season(named: String) -> Season?
}

final class LocalFactory: HouseFactory {
    
    var houses: [House] {
        // Houses creation here
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón Tricéfalo")

        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")! )
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        // Add characters to houses
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cersei)
        lannisterHouse.add(person: jaime)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first

        return house
    }
    
    func houses(filteredBy: HouseFilter) -> [House] {
        return Repository.local.houses.filter(filteredBy)
    }
}

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        let seasonOne = Season(name: "T1", releaseDate: Date.init(dateString: "2011-04-17"), firstEpisodeTitle: "Winter Is Coming")
        let seasonTwo = Season(name: "T2", releaseDate: Date.init(dateString: "2012-04-01"), firstEpisodeTitle: "The North Remembers")
        let seasonThree = Season(name: "T3", releaseDate: Date.init(dateString: "2013-03-31"), firstEpisodeTitle: "Valar Dohaeris")
        let seasonFour = Season(name: "T4", releaseDate: Date.init(dateString: "2014-04-06"), firstEpisodeTitle: "Two Swords")
        let seasonFive = Season(name: "T5", releaseDate: Date.init(dateString: "2015-04-12"), firstEpisodeTitle: "The Wars to Come")
        let seasonSix = Season(name: "T6", releaseDate: Date.init(dateString: "2016-04-24"), firstEpisodeTitle: "The Red Woman")
        let seasonSeven = Season(name: "T7", releaseDate: Date.init(dateString: "2017-07-16"), firstEpisodeTitle: "Dragonstone")
        
        let _ = Episode(title: "The Kingsroad", issueDate: Date.init(dateString: "2011-04-24"), season: seasonOne)
        let _ = Episode(title: "Lord Snow", issueDate: Date.init(dateString: "2011-05-01"), season: seasonOne)
        let _ = Episode(title: "Cripples, Bastards, and Broken Things", issueDate: Date.init(dateString: "2011-05-08"), season: seasonOne)
        
        let _ = Episode(title: "The Night Lands", issueDate: Date.init(dateString: "2012-04-08"), season: seasonTwo)
        let _ = Episode(title: "Dark Wings, Dark Words", issueDate: Date.init(dateString: "2013-04-07"), season: seasonThree)
        let _ = Episode(title: "The Lion and the Rose", issueDate: Date.init(dateString: "2014-04-13"), season: seasonFour)
        let _ = Episode(title: "The House of Black and White", issueDate: Date.init(dateString: "2015-04-12"), season: seasonFive)
        let _ = Episode(title: "Home", issueDate: Date.init(dateString: "2016-05-01"), season: seasonSix)
        let _ = Episode(title: "Stormborn", issueDate: Date.init(dateString: "2017-07-23"), season: seasonSeven)
        
        return [seasonSeven, seasonSix, seasonFive, seasonFour, seasonThree, seasonTwo, seasonOne].sorted()
    }
    
    func season(named: String) -> Season? {
        let season = seasons.filter{ $0.name.uppercased() == named.uppercased() }.first
        
        return season
    }
    
    func seasons(filteredBy: SeasonFilter) -> [Season] {
        return Repository.local.seasons.filter(filteredBy)
    }
}
