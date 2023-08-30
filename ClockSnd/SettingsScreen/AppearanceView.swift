//
//  AppearanceView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import SwiftUI

struct AppearanceView: View {
    @State private var selectedTheme: AppTheme = .light

    var body: some View {
        VStack {
            Text("Appearance")
                .font(.title)
                .padding(.top, 20)
            
            Picker("Theme", selection: $selectedTheme) {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Text(theme.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer()

            Text("Customize the appearance of the app.")
                .font(.body)
                .foregroundColor(.gray)
                .padding()
        }
        .navigationBarTitle("Appearance", displayMode: .inline)
    }
}

enum AppTheme: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"

    var id: String { self.rawValue }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
    }
}
