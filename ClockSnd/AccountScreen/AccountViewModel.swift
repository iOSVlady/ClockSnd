//
//  AccountViewModel.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 29.08.2023.
//

import Foundation
import FirebaseAuth

class AccountViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var userName: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
            } else {
                self.alertMessage = "Registration Successful!"
            }
            self.showAlert = true
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
            } else {
                self.alertMessage = "Sign In Successful!"
            }
            self.showAlert = true
        }
    }
    
    func account() {
        
    }
}
