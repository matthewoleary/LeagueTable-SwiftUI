//
//  Transitions.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade : AnyTransition {
        .asymmetric(
            insertion: .push(from: .trailing).combined(with: .scale).combined(with: .opacity),
            removal: .push(from: .leading).combined(with: .scale).combined(with: .opacity)
        )
    }
}
