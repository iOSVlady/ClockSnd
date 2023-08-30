//
//  HelpView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack {
            Text("Help Center")
                .font(.title)
                .padding(.top, 20)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HelpItem(title: "Getting Started", content: "Learn how to get started with our app.")
                    HelpItem(title: "FAQs", content: "Frequently Asked Questions to help you navigate.")
                    HelpItem(title: "Contact Us", content: "Reach out to our support team for assistance.")
                    // Add more HelpItems as needed
                }
                .padding()
            }
        }
        .navigationBarTitle("Help", displayMode: .inline)
    }
}

struct HelpItem: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            Text(content)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
