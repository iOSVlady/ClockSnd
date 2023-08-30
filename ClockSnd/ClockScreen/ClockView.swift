//
//  ClockView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI
import Combine

struct ClockView: View {
    @ObservedObject var viewModel: ClockViewModel
    @Binding var isClockShown: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            viewModel.backgroundColor
                .ignoresSafeArea()
            
            if viewModel.showInstruments {
                GeometryReader { geometry in
                    clockView.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }.transition(.identity)
            } else {
                clockView.transition(.identity)
            }

            GeometryReader { geometry in
                ZStack {
                    instrumentsView
                        .position(x: geometry.size.width / 2, y: 50)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
            }
            .opacity(viewModel.showInstruments ? 1 : 0)
            .transition(.opacity)
        }
        .onTapGesture {
            withAnimation() {
                viewModel.showInstruments.toggle()
            }
        }
        .statusBar(hidden: true)
    }
}

extension ClockView {
    
    var clockView: some View {
        Group {
            VStack(spacing: 0) {
                Spacer()
                hourView
                dividerView
                    .frame(width: 80, height: 100)
                    .padding(.vertical, -25)
                minutesView
                Spacer()
                }
            .onAppear {
                let _ = self.viewModel.updateTimer
            }
            
        }
    }
    
    var hourView: some View {
        Group {
            if viewModel.rotationIndex == 1 {
                HStack {
                    SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, viewModel.hour)
                        .foregroundColor(viewModel.textColor)
                }.rotationEffect(.degrees(90))
            } else if viewModel.rotationIndex == 2 {
                HStack {
                    SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, viewModel.hour)
                        .foregroundColor(viewModel.textColor)
                }.rotationEffect(.degrees(270))
            } else {
                SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, viewModel.hour)
                    .foregroundColor(viewModel.textColor)
            }
        }
    }
    
    var minutesView: some View {
        Group {
            if viewModel.rotationIndex == 1 {
                HStack {
                    SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, viewModel.minute)
                        .foregroundColor(viewModel.textColor)
                }.rotationEffect(.degrees(90))
            } else if viewModel.rotationIndex == 2 {
                HStack {
                    SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, viewModel.minute)
                        .foregroundColor(viewModel.textColor)
                }.rotationEffect(.degrees(270))
            } else {
                SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, viewModel.minute)
                    .foregroundColor(viewModel.textColor)
            }
        }
    }
    
    var dividerView: some View {
        Group {
            if viewModel.rotationIndex == 1 {
                HStack {
                    SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, ":")
                        .foregroundColor(viewModel.textColor)
                        .padding(.bottom, 40)
                }.rotationEffect(.degrees(90))
            } else if viewModel.rotationIndex == 2  {
                HStack {
                    SndText(family: viewModel.font, style: viewModel.style, size: viewModel.size, ":")
                        .foregroundColor(viewModel.textColor)
                        .padding(.bottom, 40)
                }.rotationEffect(.degrees(270))
            }
        }
    }
    
    var instrumentsView: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        isClockShown = false
                    }
                } label: {
                    SndText(family: viewModel.font, style: .extraBold, "Back")
                }
                .font(.headline)
                .foregroundColor(viewModel.backgroundColor)
                .padding()
                .background(viewModel.textColor)
                .cornerRadius(10)
                Spacer()
                Button {
                    withAnimation {
                        if viewModel.rotationIndex < 2 {
                            viewModel.rotationIndex += 1
                        } else {
                            viewModel.rotationIndex = 0
                        }
                    }
                } label: {
                    SndText(family: viewModel.font, style: .extraBold, "Orientation")
                }
                .font(.headline)
                .foregroundColor(viewModel.backgroundColor)
                .padding()
                .background(viewModel.textColor)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}
