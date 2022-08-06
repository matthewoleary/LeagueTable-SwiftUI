//
//  FramedText.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import SwiftUI

struct FramedTextView: View {
    let value: String
    let customFont: Font
    let width: CGFloat
    let height: CGFloat
    let alignment: Alignment
    
    init(column value: String, font: Font, width: CGFloat = 50, height: CGFloat = 30, alignment: Alignment = .center) {
        self.value = value
        self.customFont = font
        self.width = width
        self.height = height
        self.alignment = alignment
    }
    
    var body: some View {
        Text(value).font(customFont).frame(width: width, height: height, alignment: alignment)
    }
}

struct FramedTextView_Previews: PreviewProvider {
    static let premTeams: PremTeamsDTO? = Services.loadJson(file: "LeagueTable")
    
    static var previews: some View {
        FramedTextView(column: "Won", font: .custom(Fonts.leagueFont, size: 14))
    }
}
