//
//  TicketEditView.swift
//  RTicket
//
//  Created by Peter Loux on 7/1/24.
//

import SwiftUI
import RealmSwift

struct TicketEditView: View {
    @ObservedRealmObject var ticket: Ticket
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var details: String
    
    init(ticket: Ticket) {
        self.ticket = ticket
        _title = State(initialValue: ticket.title)
        _details = State(initialValue: ticket.details ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                }
                Section(header: Text("Details")) {
                    TextField("Details", text: $details)
                }
            }
            .navigationBarTitle("Edit Ticket", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                saveChanges()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func saveChanges() {
        if let realm = ticket.realm {
            try? realm.write {
                ticket.title = title
                ticket.details = details
            }
        }
    }
}

#Preview {
    TicketEditView(ticket: Ticket())
}
