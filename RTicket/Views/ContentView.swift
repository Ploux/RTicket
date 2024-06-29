//
//  ContentView.swift
//  RTicket
//
//  Created by Peter Loux on 6/28/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username: String = ""
    var body: some View {
        
        NavigationView {
            if username == "" {
                LoginView(username: $username)
            } else {
                ProductsView(username: username)
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
