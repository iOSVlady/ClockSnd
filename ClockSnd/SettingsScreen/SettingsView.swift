//
//  SettingsView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct SettingsView: View {
    @State private var isSignedIn = true

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SndText(style: .extraBold, size: 32, "Settings")
                    .padding(.vertical, 5)
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 20) {
                    settingsButton(label: "Account") {
                        // Дії для розділу "Account"
                    }
                    
                    settingsButton(label: "Appearance") {
                        // Дії для розділу "Appearance"
                    }
                    
                    settingsButton(label: "Help") {
                        // Дії для розділу "Help"
                    }
                    
                    settingsButton(label: "About") {
                        // Дії для розділу "About"
                    }
                    
                    if isSignedIn {
                        settingsButton(label: "Sign Out", color: .customColor3) {
                            signOut()
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    func settingsButton(label: String, color: Color = .primary, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                SndText(style: .bold, label)
                    .font(.headline)
                    .foregroundColor(color)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }.padding(.horizontal, 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func signOut() {
        // Виконайте дії виходу з облікового запису тут
        isSignedIn = false
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
