//
//  ClockView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct ClockView: View {
    @State var hour = ""
    @State var minute = ""
    @State var showInstruments = false
    @State var screenOrientationLandscape = false
    @Binding var clockShown: Bool
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                             block: {_ in
            self.hour = Date().formatted(Date.FormatStyle().hour(.twoDigits(amPM: .omitted)))
            self.minute = Date().formatted(Date.FormatStyle().minute())

        })
    }
    var body: some View {
        ZStack {
            Color.customColor11
                .ignoresSafeArea()
            
                VStack {
                    hourView
                    minutesView
                }
            .onAppear {
                let _ = self.updateTimer
            }
            if showInstruments {
                instruments
            }
        }
        
        .onTapGesture {
            withAnimation() {
                showInstruments.toggle()
            }
        }.statusBar(hidden: true)
    }
}

extension ClockView {
    var hourView: some View {
        Group {
            if screenOrientationLandscape {
                HStack {
                    SndText(family: .nunito, size: 200, hour)
                        .foregroundColor(.customColor1)
                }.rotationEffect(.degrees(90))
            } else {
                SndText(family: .nunito, size: 200, hour)
                    .foregroundColor(.customColor1)
            }
        }
    }
    
    var minutesView: some View {
        Group {
            if screenOrientationLandscape {
                HStack {
                    SndText(family: .nunito, size: 200, minute)
                        .foregroundColor(.customColor1)
                }.rotationEffect(.degrees(90))

            } else {
                SndText(family: .nunito, size: 200, minute)
                    .foregroundColor(.customColor1)
            }
        }
    }
    
    var instruments: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        clockShown.toggle()
                    }
                } label: {
                    SndText(family: .nunito, style: .extraBold, "Back")
                }
                .font(.headline)
                .foregroundColor(.customColor11)
                .padding()
                .background(Color.customColor1)
                .cornerRadius(10)
                Spacer()
                Button {
                    withAnimation {
                        screenOrientationLandscape.toggle()
                    }
                } label: {
                    SndText(family: .nunito, style: .extraBold, "Orientation")
                }
                .font(.headline)
                .foregroundColor(.customColor11)
                .padding()
                .background(Color.customColor1)
                .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
    }
}
