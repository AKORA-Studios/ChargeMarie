//
//  App.swift
//  ChargeMarie
//
//  Created by Kiara on 11.05.23.
//

import SwiftUI

@main
struct ChargeMarie: App {
    @StateObject var appState = AppStatus()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appState.isLoggedIn {
                    ContentView()
                } else {
                    LoginView()
                }
                //Overlays
                if appState.showToast {
                    Toast()
                }
                if appState.isLoading {
                    RoundedRectangle(cornerRadius: 8).fill(Color.gray).frame(width: 50, height: 50)
                    Rectangle().fill(Color.black).opacity(0.5).ignoresSafeArea()
                    ProgressView()
                }
            }
            .disabled(appState.isLoading)
            .environmentObject(appState)
            .onAppear{
                let userData = DataStorage.getData()
                if ((userData.username) != "") {
                    appState.startLoading()
                    Requests.login(force: false) { (result) in
                        switch (result) {
                        case .failure:
                            appState.logout()
                            break;
                        case .success:
                            appState.login()
                        }
                    }
                    appState.endLoading()
                }
            }
        }
    }
}

class AppStatus: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var showToast: Bool = false
    
    func startLoading(){
        DispatchQueue.main.async{
            self.isLoading = true
        }
    }
    
    func endLoading() {
        DispatchQueue.main.async{
            self.isLoading = false
        }
    }
    
    func login(){
        DispatchQueue.main.async{
            self.isLoggedIn = true
        }
    }
    
    func logout(){
        DispatchQueue.main.async{
            self.isLoggedIn = false
        }
    }
}
