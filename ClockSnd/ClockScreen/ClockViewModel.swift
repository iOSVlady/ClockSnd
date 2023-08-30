//
//  ClockViewModel.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import Foundation
import SwiftUI
import Combine

class ClockViewModel: ObservableObject, Identifiable {
    let id = UUID()

    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                             block: {_ in
            self.updateTime()
        })
    }
    
    @Published var hour: String
    @Published var minute: String
    
    @Published var showInstruments: Bool
    @Published var rotationIndex: Int
    @Published var backgroundColor: Color
    @Published var textColor: Color
    @Published var font: Font.FontFamily
    @Published var size: CGFloat
    @Published var style: Font.FontStyle
    
    init(hour: String = "00",
         minute: String = "00",
         showInstruments: Bool = false,
         rotationIndex: Int = 0,
         backgroundColor: Color,
         textColor: Color,
         font: Font.FontFamily,
         size: CGFloat,
         style: Font.FontStyle) {
        self.hour = hour
        self.minute = minute
        self.showInstruments = showInstruments
        self.rotationIndex = rotationIndex
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.size = size
        self.style = style
        updateTime()
    }
    
    func updateTime() {
        self.hour = Date().formatted(Date.FormatStyle().hour(.twoDigits(amPM: .omitted)))
        self.minute = Date().formatted(Date.FormatStyle().minute(.twoDigits))
    }
    
    
    
}
