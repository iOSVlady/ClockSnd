//
//  HomeView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

struct HomeView: View {
    @State var clockShown = false
    var body: some View {
        VStack {
            HStack {
                SndText(family: .jost, style: .extraBold, size: 32, "Home")
                Spacer()
            }
            .padding(.leading, 20)

            Spacer()
            
            Button {
                withAnimation {
                    clockShown = true
                }
            } label: {
                ScrollView {
                        HStack {
                            ClockView(clockShown: $clockShown)
                                .cornerRadius(20)
                                .disabled(true)
                                .scaleEffect(0.2)
                            
                        }
                        .padding()
                        .background(.white)
                        .foregroundColor(.customColor11)
                        
                        HStack {
                            ClockView(clockShown: $clockShown)
                                .cornerRadius(20)
                                .disabled(true)
                                .scaleEffect(0.2)
                                
                        }
                        .padding()
                        .background(.white)
                        .foregroundColor(.customColor11)
                    
                    
                }
            }
            
           


        Spacer()
        }.fullScreenCover(isPresented: $clockShown) {
            ClockView(clockShown: $clockShown)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
