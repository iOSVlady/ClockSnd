//
//  TabBarView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedTab = "home"
    let tabs = ["home", "catalog", "create", "settings"]

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                ForEach(tabs, id: \.self) { tab in
                    contentView(for: tab)
                        .tag(tab)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: 1)
            .transition(.slide)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    TabButton(image: image, selectedTab: $selectedTab)

                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 35)
            .padding(.top, 10)
            .background(Color.customColor2)
            .background(Color.customColor7.shadow(color: .white.opacity(0.28), radius: 5, x: 0, y: -5))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.28), radius: 30)
        }
        .ignoresSafeArea()
    }
    
    func contentView(for tab: String) -> some View {
        switch tab {
        case "catalog":
            return AnyView(StoreView())
        case "home":
            return AnyView(HomeView())
        case "settings":
            return AnyView(SettingsView())
        case "create":
            return AnyView(ClockCreatorView())
        default:
            return AnyView(EmptyView())
        }
    }
    
}

struct TabButton: View {
    var image: String
    @Binding var selectedTab: String
    var body: some View {
        Button(action: {
            withAnimation {
                print("\(image)")
                print("\(selectedTab)")
                selectedTab = image
            }
        }) {
            VStack {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(selectedTab == image ? Color.white : Color.customColor5)
                    .font(.title2)
                    
                

            }.padding(.horizontal, 20)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
