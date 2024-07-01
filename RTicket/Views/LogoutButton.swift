//
//  LogoutButton.swift
//  RTicket
//
//  Created by Peter Loux on 6/30/24.
//

import SwiftUI


struct LogoutButton: View {
    @Binding var username: String
    
    @State private var isConfirming = false
    
    var body: some View {
        Button("Logout") { isConfirming = true }
            .confirmationDialog("Are you that you want to logout",
                                isPresented: $isConfirming) {
                Button("Confirm Logout", role: .destructive) { logout() }
                Button("Cancel", role: .cancel) {}
            }
    }
    
    private func logout() {
        Task {
            do {
                try await realmApp.currentUser?.logOut()
                username = ""
            } catch {
                print("Failed to logout: \(error.localizedDescription)")
            }
        }
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton(username: .constant("andrew"))
    }
}

#Preview {
    LogoutButton(username: .constant("Peter"))
}
