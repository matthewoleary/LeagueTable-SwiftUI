//
//  ContentView.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 6/08/2022.
//

import SwiftUI

struct ContentView: View {

    /// Conditional to check if table columns are expanded or hidden
    @State private var isExpanded: Bool

    let table: PremTable
    let customFontName: String
    
    init(table: PremTable, fontName: String, isExpanded: Bool) {
        self.table = table
        self.customFontName = fontName
        self.isExpanded = isExpanded
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : Fonts.customUIFont(customFontName, size: 35),
                                                                 .foregroundColor : UIColor(Colors.leagueColor)]
    }

    var body: some View {
        NavigationStack {
            VStack {
                ExpandButton(isExpanded: $isExpanded)
                LeagueTableHeaders(isExpanded: $isExpanded)
                LeagueTable(isExpanded: $isExpanded, table: table)
            }
            .navigationTitle("Premier League")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let premTeams: PremTeamsDTO = Services.loadJson(file: "LeagueTable")!
    
    static var previews: some View {
        ContentView(table: PremTable(teams: premTeams.records), fontName: Fonts.leagueFont, isExpanded: true)
    }
}
