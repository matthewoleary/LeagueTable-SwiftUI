//
//  PremierLeagueTableApp.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 28/07/2022.
//

import SwiftUI

@main
struct PremierLeagueTableApp: App {
    var loadedPremTeams: PremTeamsDTO? = Services.loadJson(file: "LeagueTable")
    
    var body: some Scene {
        WindowGroup {
            ContentView(table: PremTable(teams: loadedPremTeams!.records), fontName: Fonts.leagueFont, isExpanded: false)
        }
    }
}
