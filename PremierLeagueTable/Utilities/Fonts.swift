//
//  Fonts.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import Foundation
import SwiftUI

struct Fonts {
    static let leagueFont: String = "Poppins-SemiBold"
    
    static func customUIFont(_ name: String, size: CGFloat) -> UIFont {
        UIFont(name: name, size: size)!
    }
}
