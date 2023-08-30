//
//  HomeViewModel.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 26.08.2023.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var clockView: ClockView?

    let config1 = SndClock(font: "Nunito", size: 200, fontStyle: "italic", textColor: Color.white, backgroundColor: Color.black,
                            backgroundImage: nil, backgroundVideoImage: nil)

    let config2 = SndClock(font: "Nunito", size: 200, fontStyle: "bold", textColor: Color.customColor1, backgroundColor: Color.customColor11,
                            backgroundImage: nil, backgroundVideoImage: nil)

    let config3 = SndClock(font: "Jost", size: 180, fontStyle: "italic", textColor: Color.blue, backgroundColor: Color.white,
                            backgroundImage: nil, backgroundVideoImage: nil)

    let config4 = SndClock(font: "Jost", size: 220, fontStyle: "regular", textColor: Color.green, backgroundColor: Color.customColor2,
                            backgroundImage: nil, backgroundVideoImage: nil)

    let config5 = SndClock(font: "Nunito", size: 180, fontStyle: "italic", textColor: Color.yellow, backgroundColor: Color.blue,
                            backgroundImage: nil, backgroundVideoImage: nil)

    let config6 = SndClock(font: "Nunito", size: 160, fontStyle: "regular", textColor: Color.red, backgroundColor: Color.white,
                            backgroundImage: nil, backgroundVideoImage: nil)

    let config7 = SndClock(font: "Jost", size: 200, fontStyle: "bold", textColor: Color.orange, backgroundColor: Color.black,
                            backgroundImage: nil, backgroundVideoImage: nil)

    let config8 = SndClock(font: "Jost", size: 180, fontStyle: "regular", textColor: Color.purple, backgroundColor: Color.customColor3,
                            backgroundImage: nil, backgroundVideoImage: nil)
    


    var arrayOfClockConfigurations: [SndClock] = []

    
    init() {
        arrayOfClockConfigurations = [config1, config2, config3, config4, config5, config6, config7, config8]
    }
}
