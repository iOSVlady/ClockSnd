//
//  ClockModel.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 26.08.2023.
//

import Foundation
import SwiftUI

struct SndClock: Identifiable, Hashable {
    let id = UUID()

    var font: String
    var size: Double
    var fontStyle: String
    var textColor: Color
    var backgroundColor: Color
    var backgroundImage: URL?
    var backgroundVideoImage: URL?
}
