//
//  LoginView.swift
//  RTicket
//
//  Created by Peter Loux on 6/28/24.
//

import SwiftUI

struct LoginView: View {
    //if I update username in this view it will be updated in ContentView
    @Binding var username: String
    
    var body: some View {
        ProgressView()
            .task {
                await login()
            }
    }
    
    private func login() async {
        do {
            let _ = try await realmApp.login(credentials: .anonymous)
            username = realmApp.currentUser!.id
        } catch {
            print("Failed to login to Realm: \(error.localizedDescription)")
        }
    }
}

#Preview {
    LoginView(username: .constant(""))
}
