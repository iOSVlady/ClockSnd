//
//  ClockCreatorView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import SwiftUI

struct ClockCreatorView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var isClockShown = false
    @StateObject var viewModel = ClockCreatorViewModel()
    @State var divider = 1.7
    @State private var showMessage = true
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            HStack {
                SndText(style: .extraBold, size: 32, "Clock Creator")
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            
            Spacer()
            
            HStack {
                VStack(spacing: 15) {
                    Button {
                        withAnimation {
                            viewModel.selectedCustomizer = .color
                            viewModel.selectedPicker = .background
                        }
                    } label: {
                        SndText(style: viewModel.selectedPicker == .background && viewModel.selectedCustomizer == .color ? .extraBold : .regular,
                                "Background")
                        .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.selectedCustomizer = .color
                            viewModel.selectedPicker = .clock
                        }
                    } label: {
                        SndText(style: viewModel.selectedPicker == .clock && viewModel.selectedCustomizer == .color ? .extraBold : .regular, "Clock")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.selectedCustomizer = .size
                        }
                    } label: {
                        SndText(style: viewModel.selectedCustomizer == .size ? .extraBold : .regular, "Size")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.selectedCustomizer = .spacing
                        }
                    } label: {
                        SndText(style: viewModel.selectedCustomizer == .spacing ? .extraBold : .regular, "Spacing")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.selectedCustomizer = .font
                        }
                    } label: {
                        SndText(style: viewModel.selectedCustomizer == .font ? .extraBold : .regular, "Font")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.selectedCustomizer = .fontStyle
                        }
                    } label: {
                        SndText(style: viewModel.selectedCustomizer == .fontStyle ? .extraBold : .regular, "Font Style")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.saveToFirebase()
                            viewModel.selectedCustomizer = .save
                            viewModel.saveClock()
                            showMessage = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.easeInOut) {
                                    showMessage = false
                                }
                            }
                            
                        }
                    } label: {
                        HStack {
                            SndText("Save")
                                .foregroundColor(colorScheme == .light ? .customColor1 : .customColor2)
                                .padding(7)
                        }
                        .background(colorScheme == .light ? Color.customColor4 : Color.customColor1)
                        .cornerRadius(10)
                    }
                    
                    if viewModel.selectedCustomizer == .font {
                        HStack(spacing: 0) {
                            Picker(selection: $viewModel.font, label: Text("")) {
                                ForEach(Font.FontFamily.allFontFamilies, id: \.self) { fontFamily in
                                    Text(fontFamily.rawValue)
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if viewModel.selectedCustomizer == .fontStyle {
                        HStack(spacing: 0) {
                            Picker(selection: $viewModel.fontStyle, label: Text("")) {
                                ForEach(Font.FontStyle.allFontFamilies, id: \.self) { fontStyle in
                                    Text(fontStyle.description)
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if viewModel.selectedCustomizer == .size {
                        HStack(spacing: 0) {
                            Picker(selection: $viewModel.size, label: Text("")) {
                                ForEach(1 ..< 201, id: \.self) { fontSize in
                                    Text("\(fontSize)%")
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if viewModel.selectedCustomizer == .spacing {
                        HStack(spacing: 0) {
                            Picker(selection: $viewModel.spacing, label: Text("")) {
                                ForEach(-60 ..< 20, id: \.self) { spacingSize in
                                    Text("\(spacingSize)%")
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if viewModel.selectedCustomizer == .save && showMessage {
                        HStack(spacing: 0) {
                            SndText(style: .bold, "Saved")
                                .foregroundColor(colorScheme == .light ? .customColor4 : .customColor1)
                                .padding(7)
                        }
                    }
                }
                .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0))
                .shadow(radius: 4)
                .frame(minWidth: 100)
                ClockView(clockModel: SndClock(font: viewModel.font.rawValue, size: String(viewModel.size), spacing: String(viewModel.spacing), fontStyle: viewModel.fontStyle.rawValue, textColor: viewModel.fontColor.toHexWithAlpha(), backgroundColor: viewModel.backgroundColor.toHexWithAlpha()), scaleEffect: 0.7)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(colorScheme == .light ? .clear : Color.customColor5, lineWidth: 1)
                    )
                    .disabled(true)
                    .frame(width: 250, height: 500)
                    .onTapGesture {
                        isClockShown = true
                    }.overlay {
                        VStack {
                            Spacer()
                            if viewModel.selectedCustomizer == .color {
                                ColorPicker("Picker", selection: selectedColorBinding)
                                    .scaleEffect(3)
                                    .labelsHidden()
                                    .padding(.bottom, -15)
                            }
                        }
                    }
                
            }
            .fullScreenCover(isPresented: $isClockShown) {
                ClockView(clockModel: SndClock(font: viewModel.font.rawValue, size: String(viewModel.size), spacing: String(viewModel.spacing), fontStyle: viewModel.fontStyle.rawValue, textColor: viewModel.fontColor.toHexWithAlpha(), backgroundColor: viewModel.backgroundColor.toHexWithAlpha()))
                    .onAppear {
                        viewModel.clockManager.clockView = ClockView(clockModel: SndClock(font: viewModel.font.rawValue, size: String(viewModel.size), spacing: String(viewModel.spacing), fontStyle: viewModel.fontStyle.rawValue, textColor: viewModel.fontColor.toHexWithAlpha(), backgroundColor: viewModel.backgroundColor.toHexWithAlpha()))
                    }
                    .onDisappear {
                        viewModel.clockManager.clockView = nil
                    }
            }
            .padding(.bottom, 100)
            Spacer()
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
    
    var selectedColorBinding: Binding<CGColor> {
        switch viewModel.selectedPicker {
        case .background:
            return $viewModel.backgroundColor
        case .clock:
            return $viewModel.fontColor
        }
    }
}

