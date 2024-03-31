//
//  AboutView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(.top, 20)
                .shadow(radius: 5)

            Text("Clock Stand")
                .font(.title)
                .padding(.top, 10)

            Text("Version 1.0")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 5)

            Spacer()

            Text("About Your App")
                .font(.headline)
                .padding(.top, 20)

            Text("This app is designed to enhance your workspace with a customizable clock that pleases your eyes.")
                .font(.body)
                .padding()

            Spacer()

            Text("Copyright © 2024 ClockSnd")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .padding()
        .navigationBarTitle("About", displayMode: .inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
