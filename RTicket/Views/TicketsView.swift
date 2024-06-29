//
//  TicketsView.swift
//  RTicket
//
//  Created by Peter Loux on 6/28/24.
//

import SwiftUI
import RealmSwift


struct TicketsView: View {
    
    @ObservedResults(Ticket.self, sortDescriptor: SortDescriptor(keyPath: "status", ascending: false)) var tickets
    @Environment(\.realm) var realm
    
    let username: String
    let product: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TicketsView(username: "peteloux", product: "MongoDB")
}
