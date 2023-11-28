//
//  GlobalClockManager.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 26.08.2023.
//

import Foundation
import SwiftUI
import CoreData
import RealmSwift

class GlobalClockManager: ObservableObject {
    @Published var arrayOfClockConfigurations: [SndClock] = []
    @Published var savedClocks: [SndClock] = []
    let realmManager: RealmManager = RealmManager.shared
    
    var clockView: ClockView? {
        didSet {
            if let newClockSet = clockView?.clockModel {
                if arrayOfClockConfigurations.count > 9,
                   let currentObject = realmManager.getAllObjects(config: .recentClocks).min(by: { $0.recentTimeStamp < $1.recentTimeStamp }) {
                    realmManager.deleteClock(clock: currentObject, config: .recentClocks)
                }
                
                realmManager.addClock(clock: newClockSet, config: .recentClocks)
                syncClocksWithDB()
            }
        }
    }
    
    public static let shared: GlobalClockManager = GlobalClockManager()
    
    private init() {
        syncClocksWithDB()
    }
    
    public func syncClocksWithDB() {
        arrayOfClockConfigurations = realmManager.getAllObjects(config: .recentClocks)
        savedClocks = realmManager.getAllObjects(config: .savedClocks, sortBy: .timeOfCreation)
    }
    
}





//
//let config1 = SndClock(font: "Nunito", size: "200", fontStyle: "italic", textColor: Color.white.toHexWithOpacity(), backgroundColor: Color.black.toHexWithOpacity())
//
//let config2 = SndClock(font: "Nunito", size: "200", fontStyle: "bold", textColor: Color.customColor1.toHexWithOpacity(), backgroundColor: Color.customColor11.toHexWithOpacity())
//
//let config3 = SndClock(font: "Jost", size: "180", fontStyle: "italic", textColor: Color.init(red: 0, green: 0, blue: 255/255).toHexWithOpacity(), backgroundColor: Color.init(red: 0, green: 0, blue: 0).toHexWithOpacity())
//
//let config4 = SndClock(font: "Jost", size: "220", fontStyle: "regular", textColor: Color.init(red: 0, green: 1, blue: 0).toHexWithOpacity(), backgroundColor: Color.customColor2.toHexWithOpacity())
//
//let config5 = SndClock(font: "Nunito", size: "180", fontStyle: "italic", textColor: Color.init(red: 1, green: 1, blue: 0).toHexWithOpacity(), backgroundColor: Color.init(red: 0, green: 0, blue: 255/255).toHexWithOpacity())
//
//let config6 = SndClock(font: "Nunito", size: "160", fontStyle: "regular", textColor: Color.init(red: 1, green: 0, blue: 0).toHexWithOpacity(), backgroundColor: Color.init(red: 1, green: 1, blue: 1).toHexWithOpacity())
//
//let config7 = SndClock(font: "Jost", size: "200", fontStyle: "bold", textColor: Color.init(red: 247/255, green: 206/255, blue: 70/255).toHexWithOpacity(), backgroundColor: Color.init(red: 0, green: 0, blue: 0).toHexWithOpacity())
//
//let config8 = SndClock(font: "Jost", size: "180", fontStyle: "regular", textColor: Color.init(red: 183/255, green: 46/255, blue: 244/255).toHexWithOpacity(), backgroundColor: Color.customColor3.toHexWithOpacity())
