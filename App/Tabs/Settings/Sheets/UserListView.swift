//
//  UserListView.swift
//  openWB App
//
//  Created by AKORA on 24.04.22.
//

import SwiftUI

struct APIUserWithUUID: Identifiable {
    var id: UUID = UUID()
    
    let username, tagName: String
    let admin: Bool
}

enum FetchState {
    case idle
    case fetching
    case fetchError
    case fetchDone
    case processing
    case processError
    case done
}

struct UserListView: View {
    @State private var userList: [APIUserWithUUID] = []
    @State private var fetchState: FetchState = .idle
    
    func fetchUsers() {
        self.fetchState = .fetching
        Requests.getJSON("user/all", type: APIAllUsers.self) { result in
            switch (result) {
            case .success(let list):
                self.userList = list.map { APIUserWithUUID(username: $0.username, tagName: $0.tagName, admin: $0.admin) }
                self.fetchState = .fetchDone
                break;
            case .failure(let err):
                self.fetchState = .fetchError
                print(getErrorAlert(err).message ?? "Couldnt Change Password")
                break;
            }
        }
        
    }
    
    var body: some View {
        List {
            Section(header: Text("Admins")) {
                ForEach(userList) { user in
                    if user.admin {
                        HStack {
                            Image(systemName: "\(user.tagName.lowercased()).circle")
                                .foregroundColor(.orange)
                            Text(user.username)
                        }
                    }
                }
            }
            Section(header: Text("Nutzer")) {
                ForEach(userList) { user in
                    if !user.admin {
                        HStack {
                            Image(systemName: "\(user.tagName.lowercased()).circle")
                                .foregroundColor(.primary)
                            Text(user.username)
                        }
                    }
                }
            }
        }
        .padding(20.0)
        .onAppear() {
            self.fetchUsers()
        }
    }
}
