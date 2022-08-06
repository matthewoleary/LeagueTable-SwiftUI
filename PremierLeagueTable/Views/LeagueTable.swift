//
//  LeagueTable.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import SwiftUI

/// List view wich contains an expandable `LeagueTableRow` for each row of the league table.
struct LeagueTable: View {

    @Binding var isExpanded: Bool

    /// Keeps a list of the selected rows in the table.
    @State private var selection: Set<Team> = []

    let table: PremTable
    let customFont: Font = .custom(Fonts.leagueFont, size: 14)

    var body: some View {
        let tableWithIndex = table.ranked.enumerated().map({ $0 })
        
        List(tableWithIndex, id: \.element.name) { index, team in
            LeagueTableRow(isExpanded: $isExpanded,
                           rowExpanded: withAnimation { self.selection.contains(team) },
                           index: index,
                           team: team,
                           customFont: customFont)
            .onTapGesture { self.toggleSelection(team) }
        }.listStyle(.plain)
    }
    
    /// Will add or remove from the list of selected rows based on tapping an expanded vs unexpanded row.
    private func toggleSelection(_ team: Team) {
        if selection.contains(team) {
            selection.remove(team)
        } else {
            selection.insert(team)
        }
    }
}

struct LeagueTable_Previews: PreviewProvider {
    @State static var isExpanded: Bool = false
    static let premTeams: PremTeamsDTO? = Services.loadJson(file: "LeagueTable")
    
    static var previews: some View {
        LeagueTable(isExpanded: $isExpanded, table: PremTable(teams: premTeams!.records))
    }
}
