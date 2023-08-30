//
//  AccountView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 29.08.2023.
//

import SwiftUI

struct AccountView: View {
    @StateObject var authViewModel = AccountViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $authViewModel.email)
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .cornerRadius(8.0)
                    .overlay(RoundedRectangle(cornerRadius: 8.0).stroke())
                
                SecureField("Password", text: $authViewModel.password)
                    .padding()
                    .cornerRadius(8.0)
                    .overlay(RoundedRectangle(cornerRadius: 8.0).stroke())

                Button(action: {
                    authViewModel.signUp()
                }, label: {
                    Text("Sign Up")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(8.0)
                })
                .padding()
                
                Button(action: {
                    authViewModel.signIn()
                }, label: {
                    Text("Sign In")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8.0)
                })
                .padding()

                Spacer()
            }
            .padding()
            .alert(isPresented: $authViewModel.showAlert) {
                Alert(title: Text("Auth"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
