//
//  PasswordChangeView.swift
//  openWB App
//
//  Created by Akora on 31.03.22.
//

import SwiftUI

// MARK: - SwiftUI RootView
struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var firstPassword: String = ""
    @State private var secondPassword: String = ""
    @State private var firstSecured = true
    @State private var secondSecured = true
    
    var inputValid: Bool {
        get { firstPassword == secondPassword && firstPassword != "" }
        set {}
    }
    
    func changePassword() {
        let newPassword = firstPassword
        
        Requests.postJSON("user/@me", body: ["password": "\(newPassword)"], method: "PATCH") { result in
            switch (result) {
            case .success(_):
                DataStorage.saveLogIn(Requests.user!.username, newPassword)
                self.presentation.wrappedValue.dismiss()
                break;
            case .failure(let err):
                DispatchQueue.main.async {
                    print(getErrorAlert(err).message ?? "Couldnt Change Password")
                }
                break;
            }
        }
        
    }
    
    var body: some View {
        VStack {
            Text("Passwort ändern")
                .font(Font.title)
            
            HStack {
                if firstSecured {
                    SecureField("Passwort", text: $firstPassword)
                } else {
                    TextField("Passwort", text: $firstPassword)
                }
                Button(action: {
                    self.firstSecured.toggle()
                }) {
                    if firstSecured {
                        Image(systemName: "eye.slash")
                    } else {
                        Image(systemName: "eye")
                    }
                }
            }
            HStack {
                if secondSecured {
                    if (inputValid) {
                        SecureField("Bestätigung", text: $secondPassword)
                    } else {
                        SecureField("Bestätigung", text: $secondPassword).border(Color.red)
                    }
                    
                } else {
                    if (inputValid) {
                        TextField("Bestätigung", text: $secondPassword)
                    } else {
                        TextField("Bestätigung", text: $secondPassword).border(Color.red)
                    }
                }
                
                
                Button(action: {
                    self.secondSecured.toggle()
                }) {
                    if secondSecured {
                        Image(systemName: "eye.slash")
                    } else {
                        Image(systemName: "eye")
                    }
                }
            }
            
            Spacer().frame(height: 50)
            
            Button(action: {
                changePassword()
            }) {
                Text("Ändern")
                    .font(Font.title2)
                    .foregroundColor(Color.primary)
            }.frame(minWidth: 100.0,  alignment: .center)
                .disabled(!inputValid)
                .padding(10.0)
                .background(Color.red.opacity(inputValid ? 1 : 0.2))
                .cornerRadius(8)
            
        }
        .textContentType(.password)
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(50.0)
        
    }
}
