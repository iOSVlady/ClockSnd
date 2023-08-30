//
//  StoreView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct StoreView: View {
    private let viewModel = HomeViewModel()
    @State var clockShown = false

    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 0) {
            SndText(family: .nunito, style: .extraBold, size: 32, "Catalog")
                .padding(.bottom, 5)
                .padding(.top, 10)
            Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.gray.opacity(0.2))
                        .shadow(radius: 5)

            ScrollView {
                LazyVGrid(columns: gridItemLayout) {
                    ForEach(viewModel.arrayOfClockConfigurations, id: \.self) { item in
                        ClockView(viewModel: ClockViewModel(
                                  backgroundColor: item.backgroundColor,
                                  textColor: item.textColor,
                                  font: Font.FontFamily(rawValue: item.font) ?? .nunito,
                                  size: item.size/2, style: Font.FontStyle(rawValue: item.fontStyle) ?? .regular),
                                  isClockShown: $clockShown)
                        .cornerRadius(20)
                        .disabled(true)
                        .shadow(radius: 5)
                        .padding(.top, 5)
                    }
                }
            }
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
