//
//  LoginView.swift
//  ChargeMarie
//
//  Created by Kiara on 07.05.23.
//

import SwiftUI


struct LoginView: View {
    @State var root = ""
    @State var username = ""
    @State var password = ""
    
    @State var errorDecription = ""
    
    @EnvironmentObject var appState: AppStatus
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Adress")
                .foregroundColor(.accentColor)
            TextField("root", text: $root)
                .padding(.bottom, 30)
            
            Text("username")
                .foregroundColor(.accentColor)
            TextField("username", text:  $username)
                .autocorrectionDisabled(true)
              
            Text("password")
                .foregroundColor(.accentColor)
            SecureField("password", text:  $password)
                .padding(.bottom, 20)
                .autocorrectionDisabled(true)
            Button("Login") {
                login()
            }.buttonStyle(PrimaryStyle())
            
            Text(errorDecription).foregroundColor(.red)
        }
        .disabled(appState.isLoading)
        .padding()
        .onAppear {
            let userData = DataStorage.getData()
            root = userData.adress ?? Requests.localRoot//TODO: as default root
            username = userData.username ?? ""
        }
        .navigationTitle("Login") // TODO: spinner, show errors, keyboard focus + autocorrect auto capitalization
    }
    
    func login() {
        appState.startLoading()
        DataStorage.saveAdress(root)
        DataStorage.saveLogIn(username, password)
        
        Requests.login(force: false) { (result) in
            switch (result) {
            case .failure(let err):
                appState.logout()
                DataStorage.logout()
                DataStorage.saveAdress(root)
                errorDecription = err.localizedDescription
            case .success:
                errorDecription = ""
                appState.login()
            }
            appState.endLoading()
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppStatus())
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
