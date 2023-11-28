//
//  AccountView.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 29.08.2023.
//

import SwiftUI

struct AccountView: View {
    @StateObject var authViewModel = AccountViewModel()
    @State var accountSignUp: Bool = false
    @State var displayView = false

    var body: some View {
        NavigationView {
            if accountSignUp {
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        SndText(family: .nunito, style: .extraBold, size: 32, "Registration")
                        Spacer()
                    }.padding(.top, 33.5)
                    
                    VStack(spacing: 5) {
                        SndTextField(text: $authViewModel.userName, fieldType: .userName)
                        SndTextField(text: $authViewModel.email, fieldType: .login)
                        SndTextField(text: $authViewModel.password, fieldType: .password)
                    }
                    .padding(.bottom, 20)
                    Spacer()
                    VStack {
                        Button(action: {
                            authViewModel.signUp()
                            
                        }, label: {
                            Text("Sign Up")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .background(Color.customColor9)
                                .cornerRadius(8.0)
                                .font(.customFont(family: .nunito, style: .bold, size: 16))
                            
                        }).shadow(radius: 4)
                        
                        Button(action: {
                            DispatchQueue.main.async {
                                withAnimation {
                                    accountSignUp = false
                                }
                            }
                        }, label: {
                            Text("Back")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .background(Color.customColor2)
                                .cornerRadius(8.0)
                                .font(.customFont(family: .nunito, style: .bold, size: 16))
                            
                        }).shadow(radius: 4)
                    }
                    Spacer()
                }
                .transition(.opacity)
                .animation(
                    .easeInOut(duration: 1),
                    value: displayView
                )
                .padding()
                .alert(isPresented: $authViewModel.showAlert) {
                    Alert(title: Text("Auth"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
            } else {
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        SndText(family: .nunito, style: .extraBold, size: 32, "Account")
                        Spacer()
                    }.padding(.top, 33.5)
                    
                    VStack(spacing: 5) {
                        SndTextField(text: $authViewModel.email, fieldType: .login)
                        SndTextField(text: $authViewModel.password, fieldType: .password)
                    }
                    .padding(.bottom, 20)
                    Spacer()
                    VStack {
                        Button(action: {
                            DispatchQueue.main.async {
                                withAnimation {
                                    accountSignUp = true
                                }
                            }
                        }, label: {
                            Text("Sign Up")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .background(Color.customColor9)
                                .cornerRadius(8.0)
                                .font(.customFont(family: .nunito, style: .bold, size: 16))
                            
                        }).shadow(radius: 4)
                        
                        Button(action: {
                            authViewModel.signIn()
                        }, label: {
                            Text("Sign In")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .background(Color.customColor2)
                                .cornerRadius(8.0)
                                .font(.customFont(family: .nunito, style: .bold, size: 16))
                            
                        }).shadow(radius: 4)
                    }
                    Spacer()
                }
                .transition(.opacity)
                .animation(
                    .easeInOut(duration: 1),
                    value: displayView
                )
                .padding()
                .alert(isPresented: $authViewModel.showAlert) {
                    Alert(title: Text("Auth"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

