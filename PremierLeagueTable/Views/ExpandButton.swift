//
//  File.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 06/08/2022.
//

import SwiftUI

struct ExpandButton: View {
    
    @Binding var isExpanded: Bool
    
    var body: some View {
        HStack {
            isExpanded ? nil : Spacer()
            Button {
                withAnimation { isExpanded.toggle() }
            } label: {
                Label("", systemImage: isExpanded ? "arrow.right.to.line" : "arrow.left.to.line")
            }
            .transition(.moveAndFade) // Transition pushes button from right to left and vice versa
            .padding(isExpanded ? .leading : .trailing, 15)
            isExpanded ? Spacer() : nil
        }.padding(.bottom, 5)
    }
}

struct ExpandButton_Previews: PreviewProvider {    
    static var previews: some View {
        Group {
            ExpandButton(isExpanded: .constant(false))
            ExpandButton(isExpanded: .constant(true))
        }
    }
}
