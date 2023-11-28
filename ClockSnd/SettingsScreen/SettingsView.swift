//
//  SettingsView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

enum SettingsSection: Identifiable {
    case account
    case appearance
    case help
    case about
    
    var id: SettingsSection { self }
}

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var isSignedIn: Bool = true
    @State private var selectedSection: SettingsSection? = nil
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SndText(style: .extraBold, size: 32, "Settings")
                    .padding(.vertical, 5)
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 14) {
                    settingsButton(label: "Account") {
                        selectedSection = .account
                    }
                    
                    settingsButton(label: "Help") {
                        selectedSection = .help
                    }
                    
                    settingsButton(label: "About") {
                        selectedSection = .about
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
        .fullScreenCover(item: $selectedSection) { section in
            NavigationView { // Embed each child view in a NavigationView
                settingsSectionView(section: section)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                selectedSection = nil // Dismiss the child view
                            }) {
                                Image(systemName: "arrow.left")
                                    .imageScale(.large)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }
                        }
                    }
            }
        }
        .opacity(isAnimating ? 1 : 0)
        .onAppear {
            withAnimation {
                isAnimating = true
            }
        }
        .onDisappear {
            withAnimation {
                isAnimating = false
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
            }
            .padding(.horizontal, 15)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .background(Color.clear)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.clear)
                .background(
                    Color.white
                        .opacity(colorScheme == .dark ? 0.1 : 0.9)
                )
                .cornerRadius(10)
        )
        .shadow(color: colorScheme == .dark ? Color.customColor4 : Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func signOut() {
        isSignedIn = false
    }
    
    func settingsSectionView(section: SettingsSection) -> some View {
        // Return the appropriate view based on the selected section
        switch section {
        case .account:
            return AnyView(AccountView())
        case .appearance:
            return AnyView(AppearanceView())
        case .help:
            return AnyView(HelpView())
        case .about:
            return AnyView(AboutView())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
