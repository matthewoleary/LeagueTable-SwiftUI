//
//  RankView.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import SwiftUI

struct RankView: View {

    let customFont: Font = .custom(Fonts.leagueFont, size: 14)
    /// Index of the row in the table, used to display a ranking in the table standings.
    let index: Int
    /// The team name used to get the corresponding club badge image.
    let name: String
    
    var body: some View {
        HStack {
            Text("\(index + 1)").font(customFont)
            Image(name)
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static let premTeams: PremTeamsDTO? = Services.loadJson(file: "LeagueTable")
    
    static var previews: some View {
        VStack {
            RankView(index: 0, name: (premTeams?.records[0].name)!)
            RankView(index: 1, name: (premTeams?.records[1].name)!)
            RankView(index: 2, name: (premTeams?.records[2].name)!)

        }
    }
}
