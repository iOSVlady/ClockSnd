//
//  HomeView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: TabBarViewModel

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
                                DispatchQueue.main.async {
                                    withAnimation {
                                        viewModel.coordinator.push(page: .clock(clock: SndClock(font: item.font, size: item.size, spacing: item.spacing, fontStyle: item.fontStyle, textColor: item.textColor, shadow: item.shadow, backgroundColor: item.backgroundColor)))
                                    }
                                }
                            } label: {
                                viewModel.coordinator.build(page: .clock(clock: SndClock(font: item.font, size: item.size, spacing: item.spacing, fontStyle: item.fontStyle, textColor: item.textColor, shadow: item.shadow, backgroundColor: item.backgroundColor), scaleEffect: 0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(colorScheme == .light ? .gray.opacity(0.3) : Color.customColor2, lineWidth: 2)
                                )
                                .shadow(color: .customColor2.opacity(0.3), radius: 2)
                                .disabled(true)
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
            DispatchQueue.main.async {
                withAnimation {
                    isAnimating = true
                }
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                withAnimation {
                    isAnimating = false
                }
            }
        }
        
    }
}
