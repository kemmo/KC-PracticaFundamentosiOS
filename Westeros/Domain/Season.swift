//
//  Season.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    let name: String
    let releaseDate: Date
    fileprivate var _episodes: Episodes
    
    init(name: String, releaseDate: Date, firstEpisodeTitle: String) {
        self.name = name
        self.releaseDate = releaseDate
        _episodes = Episodes()
        _episodes.insert(Episode(title: firstEpisodeTitle, issueDate: releaseDate, season: self))
    }
}

extension Season {
    var episodeCount: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        guard (episode.season == nil) || (episode.season == self) else {
            return
        }
        
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach{ add(episode: $0) }
    }
}

// MARK: - Proxies
extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate) \(_episodes.count)"
    }
    
    var proxyForComparison: String {
        return "\(releaseDate)"
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "(Season: \(self.name), relase date: \(self.releaseDate.stringDate()), with: \(self._episodes.count) episodes"
    }
}
