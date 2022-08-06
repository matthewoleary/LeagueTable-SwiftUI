//
//  LeagueTableRow.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import SwiftUI

struct LeagueTableRow: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var isExpanded: Bool

    let rowExpanded: Bool
    let index: Int
    let team: Team
    let customFont: Font
    
    /// Used to display the right text color depending on the expanded row background color. Works in light and dark modes.
    var expandedTextColor: Color {
        colorScheme == .light ? .white : .black
    }
    
    var body: some View {
        VStack {
            HStack {
                RankView(index: index, name: team.name).frame(width: 80, alignment: .center)
                if !isExpanded {
                    FramedTextView(column: team.shortName, font: customFont, width: 166, alignment: .leading)
                }
                Spacer()
                HStack {
                    FramedTextView(column: "\(team.played)", font: customFont)
                    if isExpanded {
                        HStack {
                            FramedTextView(column: "\(team.win)", font: customFont)
                            FramedTextView(column: "\(team.draw)", font: customFont)
                            FramedTextView(column: "\(team.loss)", font: customFont)
                        }
                        .transition(.moveAndFade)
                    }
                }
                .transition(.asymmetric(
                    insertion: .push(from: .trailing).combined(with: .opacity),
                    removal: .push(from: .leading).combined(with: .opacity)))
                FramedTextView(column: "\(team.points)", font: customFont)
            }
            if rowExpanded {
                HStack {
                    if rowExpanded {
                        Text("Last 5:").font(.custom(Fonts.leagueFont, size: 18)).padding(.trailing, 10)
                        ForEach(0..<team.form.count, id: \.self) { i in
                            switch team.form[i] {
                            case .win:
                                Circle().frame(width: 30).foregroundColor(.green)
                            case .draw:
                                Circle().frame(width: 30).foregroundColor(.gray)
                            case .loss:
                                Circle().frame(width: 30).foregroundColor(.red)
                            }
                        }
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .listRowBackground(rowExpanded ? SplashView(animationType: .topToBottom, color: Colors.leagueColor) : SplashView(animationType: .bottomToTop, color: Color(.systemBackground)))
        .foregroundColor(rowExpanded ? expandedTextColor : .primary)
    }
}

struct LeagueTableRow_Previews: PreviewProvider {
    static let premTeams: PremTeamsDTO? = Services.loadJson(file: "LeagueTable")
    
    static var previews: some View {
        Group {
            LeagueTableRow(isExpanded: .constant(false), rowExpanded: false, index: 0, team: (premTeams?.records[0])!, customFont: .custom(Fonts.leagueFont, size: 14))
                .previewLayout(.sizeThatFits)
                .previewDisplayName("League Table Row Not Expanded")
            LeagueTableRow(isExpanded: .constant(true), rowExpanded: false, index: 0, team: (premTeams?.records[1])!, customFont: .custom(Fonts.leagueFont, size: 14))
                .previewDisplayName("League Table Row Expanded")
        }
    }
}
