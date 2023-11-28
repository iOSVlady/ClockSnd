//
//  ClockView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI
import Combine

struct ClockView: View {
    @ObservedObject var clockModel: SndClock
    @Environment(\.presentationMode) var presentationMode
    @State var showInstruments: Bool = false
    @State var rotationIndex: Int = 0
    @State var hour: String = "00"
    @State var minute: String = "00"
    @State var updateTimer: Timer?
    var scaleEffect: CGFloat = 1

    var body: some View {
        ZStack(alignment: .bottom) {
            clockModel.backgroundColor.colorFromHexWithOpacity()
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                clockView
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            VStack {
                instrumentsView
                Spacer()
            }.opacity(showInstruments ? 1 : 0)
        }
        .onTapGesture {
            withAnimation() {
                showInstruments.toggle()
            }
        }
        .onAppear {
            updateTime()
            updateTimer = {
               Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                                    block: {_ in
                   updateTime()
               })
            }()
        }
        .onDisappear {
            updateTimer?.invalidate()
            updateTimer = nil
        }
        .statusBar(hidden: true)
    }
}

extension ClockView {
    
    var clockView: some View {
        VStack(spacing: 0) {
            Spacer()
            hourView
                .padding(.bottom, clockModel.spacing.toCGFloat())
            dividerView
                .frame(width: 80, height: 100)
                .padding(.vertical, -25)
            minutesView
                .padding(.top, clockModel.spacing.toCGFloat())

            Spacer()
        }.scaleEffect(clockModel.size.toCGFloat() * 0.01 * scaleEffect)
    }
    
    var hourView: some View {
        Group {
            if rotationIndex == 1 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, hour)
                        .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(90))
            } else if rotationIndex == 2 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, minute)
                        .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(270))
            } else {
                SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, hour)
                    .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
            }
        }
    }
    
    var minutesView: some View {
        Group {
            if rotationIndex == 1 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, minute)
                        .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(90))
            } else if rotationIndex == 2 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, hour)
                        .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
                }.rotationEffect(.degrees(270))
            } else {
                SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, minute)
                    .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
            }
        }
    }
    
    var dividerView: some View {
        Group {
            if rotationIndex == 1 {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, ":")
                        .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
                        .padding(.bottom, 40)
                }.rotationEffect(.degrees(90))
            } else if rotationIndex == 2  {
                HStack {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: Font.FontStyle(rawValue: clockModel.fontStyle) ?? .regular, size: 250, ":")
                        .foregroundColor(clockModel.textColor.colorFromHexWithOpacity())
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
                        updateTimer?.invalidate()
                        updateTimer = nil
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: .extraBold, "Back")
                }
                .font(.headline)
                .foregroundColor(clockModel.backgroundColor.colorFromHexWithOpacity())
                .padding()
                .background(clockModel.textColor.colorFromHexWithOpacity())
                .cornerRadius(10)
                Spacer()
                Button {
                    withAnimation {
                        if rotationIndex < 2 {
                            rotationIndex += 1
                        } else {
                            rotationIndex = 0
                        }
                    }
                } label: {
                    SndText(family: Font.FontFamily(rawValue: clockModel.font) ?? .nunito, style: .extraBold, "Orientation")
                }
                .font(.headline)
                .foregroundColor(clockModel.backgroundColor.colorFromHexWithOpacity())
                .padding()
                .background(clockModel.textColor.colorFromHexWithOpacity())
                .cornerRadius(10)
            }
            .padding()
        }
    }
    
    func updateTime() {
        hour = Date().formatted(Date.FormatStyle().hour(.twoDigits(amPM: .omitted)))
        minute = Date().formatted(Date.FormatStyle().minute(.twoDigits))
    }
}
