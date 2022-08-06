//
//  SplashShape.swift
//
// Created by Trailing Closure
//
// Source: https://trailingclosure.com/swiftui-animating-color-changes/
//

import SwiftUI

struct SplashShape: Shape {
    var progress: CGFloat
    var animationType: SplashAnimation
    
    var animatableData: CGFloat {
        get { return progress }
        set { self.progress = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        switch self.animationType {
        case .leftToRight:
            return leftToRight(rect: rect)
        case .rightToLeft:
            return rightToLeft(rect: rect)
        case .topToBottom:
            return topToBottom(rect: rect)
        case .bottomToTop:
            return bottomToTop(rect: rect)
        }
    }
    
    func leftToRight(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0)) // Top Left
        path.addLine(to: CGPoint(x: rect.width * progress, y: 0)) // Top Right
        path.addLine(to: CGPoint(x: rect.width * progress, y: rect.height)) // Bottom Right
        path.addLine(to: CGPoint(x: 0, y: rect.height)) // Bottom Left
        path.closeSubpath() // Close the Path
        return path
    }

    func rightToLeft(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: 0))
        path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
    
    func topToBottom(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * progress))
        path.addLine(to: CGPoint(x: 0, y: rect.height * progress))
        path.closeSubpath()
        return path
    }

    func bottomToTop(rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - (rect.height * progress)))
        path.addLine(to: CGPoint(x: 0, y: rect.height - (rect.height * progress)))
        path.closeSubpath()
        return path
    }
    
    public enum SplashAnimation {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
    }
}

struct SplashView: View {
    
    var animationType: SplashShape.SplashAnimation
    @State private var prevColor: Color // Stores background color
    @ObservedObject var colorStore: ColorStore // Send new color updates
    @State var layers: [(Color,CGFloat)] = [] // New Color & Progress

    
    init(animationType: SplashShape.SplashAnimation, color: Color) {
        self.animationType = animationType
        self._prevColor = State<Color>(initialValue: color)
        self.colorStore = ColorStore(color: color)
    }

    var body: some View {
        Rectangle()
            .foregroundColor(self.prevColor)
            .overlay(
                ZStack {
                    ForEach(layers.indices, id: \.self) { x in
                        SplashShape(progress: self.layers[x].1, animationType: self.animationType)
                            .foregroundColor(self.layers[x].0)
                    }
                }, alignment: .leading)
            .onReceive(self.colorStore.$color) { color in
                self.layers.append((color, 0))
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.layers[self.layers.count-1].1 = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.prevColor = self.layers[0].0 // Finalizes background color of SplashView
                        self.layers.remove(at: 0) // removes itself from layers array
                    }
                }
            }
    }
}

class ColorStore: ObservableObject {
    @Published var color: Color
    
    init(color: Color) {
        self.color = color
    }
}
