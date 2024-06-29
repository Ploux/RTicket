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
    
    
    @State private var busy = false
    @State private var title = ""
    @State private var details = ""
    
   
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(tickets) { ticket in
                        Text(ticket.title)
                    }
                }
                Spacer()
                VStack {
                    TextField("Title", text: $title)
                    TextField("Details", text: $details)
                        .font(.caption)
                    Button("Add Ticket") {
                        addTicket()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || busy)
                }
            }
            .padding()
            if busy {
                ProgressView()
            }
        }
        .onAppear (perform: subscribe)
        .onDisappear (perform: unsubscribe)
        .navigationBarTitle(product, displayMode: .inline)
    }
    
    private func addTicket() {
        let ticket = Ticket(product: product, title: title, details: details, author: username)
        $tickets.append(ticket)
        title = ""
        details = ""
    }
    
    private func subscribe() {
        let lastYear = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate.rounded() - (60 * 60 * 24 * 365))
        let subscriptions = realm.subscriptions
        if subscriptions.first(named: product) == nil {
            DispatchQueue.main.async {
                self.busy = true // Access and mutate 'busy' on the main actor
            }
            subscriptions.update {
                subscriptions.append(QuerySubscription<Ticket>(name: product) { ticket in
                    return ticket.product == product && (ticket.status != .complete || ticket.created > lastYear)
                })
            } onComplete: { error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed to subscribe for \(product): \(error.localizedDescription)")
                    }
                    self.busy = false // Access and mutate 'busy' on the main actor
                }
            }
        }
    }
    
    private func unsubscribe() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            subscriptions.remove(named: product)
        } onComplete: { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to unsubscribe for \(product): \(error.localizedDescription)")
                }
            }
        }
    }
    
}

#Preview {
    TicketsView(username: "peteloux", product: "MongoDB")
}
