//
//  File.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import SwiftUI

/// An `HStack` which displays the league table column headers.
struct LeagueTableHeaders: View {
    
    @Binding var isExpanded: Bool
    
    let customFont: Font = .custom(Fonts.leagueFont, size: 14)
    
    var body: some View {
        HStack {
            FramedTextView(column: "2021/2022", font: customFont, width: 80, height: 20)
                .foregroundColor(.gray)
                .padding(.leading, 10)
            Spacer()
            FramedTextView(column: "Played", font: customFont, width: 50, height: 20)
                .foregroundColor(.gray)
            // Toggling isExpanded will collapse to hide or expand to show these columns.
            if isExpanded {
                Group {
                    HStack {
                        FramedTextView(column: "Won", font: customFont, width: 50, height: 20, alignment: .center)
                            .foregroundColor(.gray)
                        FramedTextView(column: "Drawn", font: customFont, width: 50, height: 20, alignment: .center)
                            .foregroundColor(.gray)
                        FramedTextView(column: "Lost", font: customFont, width: 50, height: 20, alignment: .center)
                            .foregroundColor(.gray)
                    }
                    .transition(.moveAndFade)
                }
            }
            FramedTextView(column: "Points", font: customFont, width: 50, height: 20, alignment: .center)
                .foregroundColor(.gray)
                .padding(.trailing, 10)
        }
    }
}

struct LeagueTableHeaders_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LeagueTableHeaders(isExpanded: .constant(false))
                .previewLayout(.sizeThatFits)
            LeagueTableHeaders(isExpanded: .constant(true))
                .previewLayout(.sizeThatFits)
        }
    }
}
