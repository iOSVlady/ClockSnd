//
//  HomeView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @State var isClockShown: Bool = false

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
                        ForEach(viewModel.arrayOfClockConfigurations, id: \.self) { item in
                            
                            Button {
                                withAnimation {
                                    viewModel.clockView = ClockView(viewModel: ClockViewModel(
                                                                    backgroundColor: item.backgroundColor,
                                                                    textColor: item.textColor,
                                                                    font: Font.FontFamily(rawValue: item.font) ?? .nunito,
                                                                    size: item.size,
                                                                    style: Font.FontStyle(rawValue: item.fontStyle) ?? .regular),
                                                                    isClockShown: $isClockShown)
                                    isClockShown = true
                                }
                            } label: {
                                ClockView(viewModel: ClockViewModel(
                                          backgroundColor: item.backgroundColor,
                                          textColor: item.textColor,
                                          font: Font.FontFamily(rawValue: item.font) ?? .nunito,
                                          size: item.size,
                                          style: Font.FontStyle(rawValue: item.fontStyle) ?? .regular),
                                          isClockShown: $isClockShown)
                                .cornerRadius(20)
                                .disabled(true)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .scaleEffect(0.95)
                }
            }
            Spacer()
        }.fullScreenCover(isPresented: $isClockShown) {
            viewModel.clockView
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
