//
//  MainView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct MainView: View {
    @State var onboardingShown = false
    @State var orientation = UIDeviceOrientation.unknown
    var body: some View {
        Group {
            if onboardingShown {
                TabBarView()
                    .transition(.opacity.animation(.easeInOut.delay(0.2)))
            } else {
                OnboardingView(onboardingShown: $onboardingShown)
                    .transition(.move(edge: .top).combined(with: .scale(scale: 20)).combined(with: .opacity.animation(.easeIn.speed(2))))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
