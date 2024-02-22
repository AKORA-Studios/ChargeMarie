//
//  SettingsView.swift
//  openWB App
//
//  Created by AKORA on 22.04.22.
//

// MARK: - Notes
// https://swiftwithmajid.com/2019/06/19/building-forms-with-swiftui/

import SwiftUI


// MARK: - RootView
struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var appState: AppStatus
    
    @State var changingPassword = false
    @State var loggingOut = false
    
    func logout() {
        DataStorage.logout()
        appState.logout()
    }
    
    var body: some View {
        
        Form {
            Section(header: Text("Allgemeine Daten")) {
                IconButton(text: Requests.user!.username, iconName: "person.fill", iconColor: .green).buttonStyle(.plain)
                IconButton(text: Requests.user!.tagName, iconName: "tag.circle.fill", iconColor: .orange).buttonStyle(.plain)
                IconButton(text: Requests.rootAddress, iconName: "wifi", iconColor: .blue).buttonStyle(.plain)
            }
            
            if Requests.user!.admin {
                Section(header: Text("Admin"))  {
                    SheetButton(text: "Nutzerliste", iconName: "person.2", iconColor: .orange) {
                        UserListView()
                    }
                }
            }
            
            Section(header: Text("Konto")) {
                // Change Password
                SheetButton(text: "Passwort ändern", iconName: "lock.fill", iconColor: .red) {
                    ChangePasswordView()
                }
                
                // Logout
                if #available(iOS 15.0, *) {
                    IconButton(text: "Abmelden", iconName: "power.circle.fill", iconColor: .red) {
                        loggingOut = true
                    }.alert("Wirklich abmelden?", isPresented: $loggingOut){
                        Button("Nein", role: .cancel) { }
                        Button("Ja") {
                            logout()
                        }
                    }
                } else {
                    IconButton(text: "Abmelden", iconName: "power.circle.fill", iconColor: .red) {
                        logout()
                    }                }
            }.listRowBackground(Color.red.opacity(0.2))
        }
    }
}
