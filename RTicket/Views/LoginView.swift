//
//  LoginView.swift
//  RTicket
//
//  Created by Peter Loux on 6/28/24.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    
    enum Field: Hashable {
        case username
        case password
    }
    
    @Binding var username: String
    
    @State private var email = ""
    @State private var password = ""
    @State private var newUser = false
    @State private var errorMessage = ""
    @State private var inProgress = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Spacer()
                TextField("email address", text: $email)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .password }
                SecureField("password", text: $password)
                    .focused($focusedField, equals: .password)
                    .onSubmit(userAction)
                    .submitLabel(.go)
                Button(action: { newUser.toggle() }) {
                    HStack {
                        Image(systemName: newUser ? "checkmark.square" : "square")
                        Text("Register new user")
                        Spacer()
                    }
                }
                Button(action: userAction) {
                    Text(newUser ? "Register new user" : "Log in")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(email == "" || password == "")
                Spacer()
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            if inProgress {
                ProgressView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedField = .username
            }
        }
        .padding()
    }
    
    func userAction() {
        errorMessage = ""
        inProgress = true
        Task {
            do {
                if newUser {
                    try await realmApp.emailPasswordAuth.registerUser(email: email, password: password)
                }
                let _ = try await realmApp.login(credentials: .emailPassword(email: email, password: password))
                username = email
                inProgress = false
            } catch {
                errorMessage = error.localizedDescription
                inProgress = false
            }
        }
    }
}

#Preview {
    LoginView(username: .constant("Peter"))
}
