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
                            viewModel.selectedCustomizer = .font
                        }
                    } label: {
                        SndText(style: viewModel.selectedCustomizer == .font ? .extraBold : .regular, "Font")
                            .foregroundColor(colorScheme == .light ? .customColor2 : .customColor1)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.saveToFirebase()
                            viewModel.selectedCustomizer = .save
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.easeInOut) {
                                    self.showMessage = false
                                }
                            }

                        }
                    } label: {
                        HStack {
                            SndText("Save")
                                .foregroundColor(colorScheme == .light ? .customColor1 : .customColor2)
                                .padding(7)
                        }
                        .background(colorScheme == .light ? Color.customColor4 : Color.customColor2)
                        .cornerRadius(10)
                    }
                    
                    if viewModel.selectedCustomizer == .font {
                        HStack(spacing: 0) {
                            Picker(selection: self.$viewModel.font, label: Text("")) {
                                ForEach(Font.FontFamily.allFontFamilies, id: \.self) { fontFamily in
                                    Text(fontFamily.rawValue)
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if viewModel.selectedCustomizer == .size {
                        HStack(spacing: 0) {
                            Picker(selection: self.$viewModel.size, label: Text("")) {
                                ForEach(50 ..< 161, id: \.self) { fontSize in
                                    Text("\(fontSize)%")
                                        .font(.customFont(family: .nunito, style: .regular, size: 18))
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.bottom, -95)
                    } else if viewModel.selectedCustomizer == .save && showMessage {
                        HStack(spacing: 0) {
                            SndText(style: .bold, "Saved")
                                .foregroundColor(colorScheme == .light ? .customColor4 : .customColor2)
                                .padding(7)
                        }
                    }
                }
                .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0))
                .shadow(radius: 4)
                .frame(minWidth: 100)
                
                
                ClockView(viewModel: ClockViewModel(
                    backgroundColor: Color(cgColor: viewModel.backgroundColor),
                    textColor: Color(cgColor: viewModel.fontColor),
                    font: viewModel.font,
                    size: CGFloat((CGFloat(viewModel.size * 180) * 0.01)/CGFloat(divider)),
                    style: .bold), isClockShown: $isClockShown)
                
                .disabled(true)
                .cornerRadius(10)
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
                ClockView(viewModel: ClockViewModel(backgroundColor: Color(cgColor: viewModel.backgroundColor), textColor: Color(cgColor: viewModel.fontColor), font: viewModel.font, size: CGFloat(viewModel.size * 180) * 0.01, style: .bold), isClockShown: $isClockShown)
            }
            .padding(.bottom, 100)
            Spacer()
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

extension ClockCreatorView {}

struct ClockCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        ClockCreatorView()
    }
}

