//
//  StoreView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct StoreView: View {
    @State var clockShown = false
    @State var isAnimating: Bool = false
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var clockManager: GlobalClockManager = GlobalClockManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            SndText(family: .nunito, style: .extraBold, size: 32, "Your saved clocks")
                .padding(.bottom, 5)
                .padding(.top, 10)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.gray.opacity(0.2))
                .shadow(radius: 5)
            
            ScrollView {
                LazyVGrid(columns: gridItemLayout) {
                    ForEach(clockManager.savedClocks.reversed(), id: \.self) { item in
                        ClockView(clockModel: SndClock(font: item.font, size: item.size, spacing: item.spacing, fontStyle: item.fontStyle, textColor: item.textColor, backgroundColor: item.backgroundColor), scaleEffect: 0.3)
                            .frame(height: 250)
                            .frame(minWidth: 100)
//                            .scaledToFit()
                            .cornerRadius(20)
                            .disabled(true)
                            .shadow(radius: 5)
                            .padding(.top, 5)
                            .contextMenu {
                                Button("Delete") {
                                    clockManager.realmManager.deleteClock(clock: item, config: .savedClocks)
                                    clockManager.syncClocksWithDB()
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    clockManager.clockView = ClockView(clockModel: item)
                                    clockShown = true
                                }
                            }
                    }
                }.padding(.horizontal, 5)
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
        .fullScreenCover(isPresented: $clockShown) {
            clockManager.clockView
        }
    }
}
