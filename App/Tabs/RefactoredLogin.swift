import SwiftUI


struct LoginView: View {
    @State var root = ""
    @State var username = ""
    @State var password = ""

    @State var loading = false

    var body: some View {
        VStack {
            Textfield("root", $root)
             Textfield("username", $username)
              Textfield("password", $password)
              .padding(.bottom, 20)
              Button("d") {
                login()
              }
        }.onAppear {
             let userData = DataStorage.getData()
             root = userData.adress
              username = userData.username
        }
        .navigationTitle("Login") // TODO: spinner, navigationview, openapp, show errors, keyboard focus
    }

    func login() {
        loading = true
Requests.login(force: false) { (result) in
                switch (result) {
                case .failure:
                   // DataStorage.logout()
                    DispatchQueue.main.async {
                      //  self.present(getErrorAlert(.InvalidCredentials), animated: true, completion: nil);
                        
                    }
                    break;
                case .success:

                DataStorage.saveLogIn(username, password)
            DataStorage.saveAdress(adress)


                    DispatchQueue.main.async {
                        self.openApp()
                    }
                }
                  loading = false
            }
    }

      func openApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContentViewHostingController") as! ContentViewHostingController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController = vc
    }
}