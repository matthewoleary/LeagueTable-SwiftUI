//
//  PremTableDTO.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 28/07/2022.
//

import Foundation

struct PremTeamsDTO: Decodable {
    let records: [Team]
}

struct Team: Decodable, Hashable {
    let name: String
    let shortName: String
    let played: Int
    let win: Int
    let draw: Int
    let loss: Int
    let goalsFor: Int
    let goalsAgainst: Int
    let goalDifference: Int
    let points: Int
    let form: [MatchResult]
    
    private enum CodingKeys: String, CodingKey {
        case name = "team"
        case shortName, played, win, draw, loss, goalsFor, goalsAgainst, goalDifference, points, form
    }
    
    enum MatchResult: String, Decodable {
        case win = "W"
        case draw = "D"
        case loss = "L"
    }
}

extension Team: Identifiable {
    var id: String { name }
}
