//
//  OnboardingView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isAnimating: Bool = false
    @Binding var onboardingShown: Bool
    var body: some View {
        ZStack{
            Color.customColor11
            VStack {
                Spacer()
                
                VStack {
                    SndText(style: .extraBold, size: 38, "Wellcome ")
                    SndText(style: .extraBold, size: 32, "to")
                }
                .foregroundColor(.customColor1)
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .scaleEffect(isAnimating ? 1.0 : 0.3)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        UserDefaults.standard.set(true, forKey: "onboardingShown")
                        onboardingShown = true
                    }
                }) {
                    SndText(style: .bold, "Get Started")
                        .font(.headline)
                        .foregroundColor(.customColor11)
                        .padding()
                        .background(Color.customColor1)
                        .cornerRadius(10)
                }
                .padding(.bottom, 100)
                
            }
            .onAppear {
                isAnimating = false
                withAnimation(.easeOut(duration: 1.5)) {
                    self.isAnimating = true
                }
            }
        }.ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
