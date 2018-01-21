//
//  ContentItemContainer.swift
//  TraktKit
//
//  Created by Sven Bacia on 02.12.17.
//  Copyright © 2017 Sven Bacia. All rights reserved.
//

import Foundation

struct ContentItemContainer {

    let movies: [ContentItem]?
    let shows: [ContentItem]?
    let seasons: [ContentItem]?
    let episode: [ContentItem]?
    let episodes: [ContentItem]?
    let people: [ContentItem]?

    init(items: [ContentItem]) {
        var movies = [ContentItem]()
        var shows = [ContentItem]()
        var seasons = [ContentItem]()
        var episode = [ContentItem]()
        var episodes = [ContentItem]()
        var people = [ContentItem]()
        for item in items {
            switch item {
            case .movie:
                movies.append(item)
            case .show:
                shows.append(item)
            case .season:
                seasons.append(item)
            case .episode:
                episode.append(item)
            case .episodes:
                episodes.append(item)
            case .person:
                people.append(item)
            }
        }
        self.movies = movies.isEmpty ? nil : movies
        self.shows = shows.isEmpty ? nil : shows
        self.seasons = seasons.isEmpty ? nil : seasons
        self.episode = episode.isEmpty ? nil : episode
        self.episodes = episodes.isEmpty ? nil : episodes
        self.people = people.isEmpty ? nil : people
    }
}

extension ContentItemContainer {
    var asJSON: [String: Any] {
        var _movies: [[String: Any]] = []
        var _shows: [[String: Any]] = []
        var _people: [[String: Any]] = []
        var _episode: [[String: Any]] = []

        if let movies = movies {
            _movies.append(contentsOf: movies.map({ $0.asJSON }))
        }

        if let shows = shows {
            _shows.append(contentsOf: shows.map({ $0.asJSON }))
        }

        if let seasons = seasons {
            _shows.append(contentsOf: seasons.map({ $0.asJSON }))
        }

        if let episode = episode {
            _episode.append(contentsOf: episode.map({ $0.asJSON }))
        }

        if let episodes = episodes {
            _shows.append(contentsOf: episodes.map({ $0.asJSON }))
        }

        if let people = people {
            _people.append(contentsOf: people.map({ $0.asJSON }))
        }

        return [
            "movies": _movies,
            "shows": _shows,
            "episodes": _episode,
            "people": _people
        ]
    }
}
