//
//  ProductsView.swift
//  RTicket
//
//  Created by Peter Loux on 6/28/24.
//

import SwiftUI

struct ProductsView: View {
    
    let username: String
    
    // TODO: Use values from Atlas
    let products = ["MongoDB", "Atlas", "Realm", "Charts", "Compass"]
    
    var body: some View {
        List {
            
            if let realmUser = realmApp.currentUser {
                ForEach(products, id: \.self) { product in
                    
                    NavigationLink(destination: TicketsView(username: username, product: product)
                        .environment(\.realmConfiguration, realmUser.flexibleSyncConfiguration())) {
                            Text(product)
                        }
                }
            }
        }
        .navigationBarTitle("Products", displayMode: .inline)
    }
}

        #Preview {
            ProductsView(username: "test")
        }
