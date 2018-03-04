//
//  Episode.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import Foundation

final class Episode {
    let title: String
    let issueDate: Date
    let summary: String
    weak var season: Season?
    
    init(title: String, issueDate: Date, summary: String, season: Season?) {
        self.title = title
        self.issueDate = issueDate
        self.season = season
        self.summary = summary
        
        if let season = season {
            season.add(episode: self)
        }
    }
    
    func setSeason(season: Season) {
        guard let season = self.season else {
            //Cannot assign an episode to a season if the episode alredy belongs to a season
            return
        }
        
        season.add(episode: self)
    }
}

// MARK: - Proxies
extension Episode {
    var proxyForEquality: String {
        return "\(title) \(issueDate) \(season?.name ?? "Unknown")"
    }
    
    var proxyForComparison: String {
        return "\(issueDate)"
    }
}

// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        return "Episode: \(self.title), issue date: \(self.issueDate.stringDate), of season: \(self.season?.name ?? "Unknown")"
    }
}
