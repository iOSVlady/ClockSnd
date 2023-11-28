//
//  HomeView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @State var isClockShown: Bool = false
    @State var isAnimating: Bool = false
    @StateObject var clockManager: GlobalClockManager = GlobalClockManager.shared

    var body: some View {
        VStack {
            HStack {
                SndText(family: .nunito, style: .extraBold, size: 32, "Home")
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 5)
            .padding(.top, 10)
            
            VStack(spacing: 0) {
                HStack {
                    SndText(family: .nunito, style: .extraBold, size: 22, "Resent Clocks:")
                        .padding(.leading, 20)
                        .padding(.bottom, 5)

                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(clockManager.arrayOfClockConfigurations.reversed(), id: \.self) { item in
                            Button {
                                withAnimation {
                                    clockManager.clockView = ClockView(clockModel: item)
                                    isClockShown = true
                                }
                            } label: {
                                ClockView(clockModel: SndClock(font: item.font, size: "150", spacing: item.spacing, fontStyle: item.fontStyle, textColor: item.textColor, backgroundColor: item.backgroundColor), scaleEffect: 0.6)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(colorScheme == .light ? .clear : Color.customColor5, lineWidth: 1)
                                )
                                .disabled(true)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .scaleEffect(0.95)
                }
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $isClockShown) {
            clockManager.clockView
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
}
