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
    let isOnboardingPass: Bool = UserDefaults.standard.bool(forKey: "onboardingShown")
    var body: some View {
        MainFlowView(targetPage: isOnboardingPass ? .basic : .onboarding) {}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
