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
        VStack (alignment: .leading) {
            HStack {
                Text(ticket.title)
                    .font(.headline)
                    .foregroundColor(ticket.color)
                Spacer()
                DateView(date: ticket.created)
                    .font(.caption)
            }
            Text(ticket.author)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(ticket.details ?? "No details")
                .font(.caption)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            if ticket.status == .inProgress {
                Button(action: { $ticket.status.wrappedValue = .notStarted }) {
                    Label("Not Started", systemImage: "stop.circle.fill")
                }
                .tint(.red)
            }
            if ticket.status == .complete {
                Button(action: { $ticket.status.wrappedValue = .inProgress }) {
                    Label("In Progress", systemImage: "bolt.circle.fill")
                }
                .tint(.yellow)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if ticket.status == .inProgress {
                Button(action: { $ticket.status.wrappedValue = .complete }) {
                    Label("Complete", systemImage: "checkmark.circle.fill")
                }
                .tint(.green)
            }
            if ticket.status == .notStarted {
                Button(action: { $ticket.status.wrappedValue = .inProgress }) {
                    Label("In Progress", systemImage: "bolt.circle.fill")
                }
                .tint(.yellow)
            }
        }
    }
    
}

#Preview {
    let ticket1 = Ticket(product: "Realm", title: "Ticket 1", details: "Short description", author: "Peter", created: Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate - 1000000), status: .notStarted)
    let ticket2 = Ticket(product: "Realm", title: "Ticket Two", details: "Quite a long description. This may take up some space. This will show whether hte viiew can correctly display these details over multiple lines. This is the last sentence in the details.", author: "Bryan", created: Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate - 100000), status: .inProgress)
    let ticket3 = Ticket(product: "Realm", title: "Third ticket", author: "Filipe", status: .complete)
    
    return List {
        TicketView(ticket: ticket1)
        TicketView(ticket: ticket2)
        TicketView(ticket: ticket3)
    }
}
