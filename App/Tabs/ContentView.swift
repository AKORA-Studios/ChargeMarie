//
//  ContentView.swift
//  ChargeMarie
//
//  Created by Kiara on 14.01.23.
//

import SwiftUI

struct ContentView: View {
    @State var isAdmin = Requests.user!.admin
    var body: some View {
        TabView{
            LadelogView().tabItem {
                Image(systemName: "note.text")
                Text("Log")
            }
            if(isAdmin)  {
                Overview().tabItem {
                    Image(systemName: "car")
                    Text("Übersicht")
                }
                ChargingView().tabItem {
                    Image(systemName: "bolt.ring.closed")
                    Text("Übersicht")
                }
                
            }
            SettingsView().environmentObject(Settings)
                .tabItem {
                Image(systemName: "gear")
                Text("Einstellungen")
            }
        }
    }
}


class ContentViewHostingController: UIHostingController<ContentView>  {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ContentView())
    }
}
