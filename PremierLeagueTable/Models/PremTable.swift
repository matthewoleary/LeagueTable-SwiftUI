//
//  RankedPremTable.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 28/07/2022.
//

import Foundation

struct PremTable {
    let teams: [Team]
    
    var ranked: [Team] {
        return teams.sorted {
            guard $0.points == $1.points else {
                return $0.points > $1.points
            }
            guard $0.goalDifference == $1.goalDifference else {
                return $0.goalDifference > $1.goalDifference
            }
            return $0.goalsFor > $1.goalsFor
        }
    }
}
