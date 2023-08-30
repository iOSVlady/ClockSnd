//
//  ClockCreatorViewModel.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import Foundation
import CoreGraphics
import SwiftUI
import FirebaseFirestore

enum CustomizerSelector {
    case color
    case size
    case font
    case save
}

enum PickerColor {
    case background
    case clock
}


class ClockCreatorViewModel: ObservableObject {
    @Published var previewClock: ClockView?
    @Published var backgroundColor: CGColor = .init(red: 240/255, green: 230/255, blue: 220/255, alpha: 1)
    @Published var fontColor: CGColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    @Published var font: Font.FontFamily = .nunito
    @Published var size: Int = 100

    
    @Published var selectedPicker: PickerColor = .background
    @Published var selectedCustomizer: CustomizerSelector = .color
    
    private var db = Firestore.firestore()


    init(previewClock: ClockView? = nil) {
        self.previewClock = previewClock
    }
    
    func saveToFirebase() {
        let data: [String: Any] = [
            "backgroundColor": backgroundColor.hexString(),
            "fontColor": fontColor.hexString(),
            "font": "\(font)",
            "size": size
        ]
        
        db.collection("themes").addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added.")
            }
        }
    }
}

extension CGColor {
    func hexString() -> String {
        let numComponents = self.numberOfComponents
        let components = self.components
        var r, g, b: CGFloat
        
        if numComponents == 4 {
            r = components?[0] ?? 0
            g = components?[1] ?? 0
            b = components?[2] ?? 0
        } else {
            r = components?[0] ?? 0
            g = components?[0] ?? 0
            b = components?[0] ?? 0
        }
        
        return String(format: "%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }
}
