//
//  TicketView.swift
//  RTicket
//
//  Created by Peter Loux on 6/29/24.
//

import SwiftUI
import RealmSwift


struct TicketView: View {
    @ObservedRealmObject var ticket: Ticket
    
    var body: some View {
        Text(ticket.title)
    }
}

#Preview {
    let ticket1 = Ticket(product: "Realm", title: "Ticket 1", details: "Short description", author: "Peter", created: Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate - 1000000), status: .notStarted)
    let ticket2 = Ticket(product: "Realm", title: "Ticket Two", details: "Quite a long description. This may take up some space. This will show whether hte viiew can correctly display these details over multiple lines. This is the last sentence in the details.", author: "Bryan", created: Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate - 100000), status: .inProgress)
    let ticket3 = Ticket(product: "Realm", title: "Third ticket", details: "Realm", author: "Filipe")
    
    return List {
        TicketView(ticket: ticket1)
        TicketView(ticket: ticket2)
        TicketView(ticket: ticket3)
    }
}
