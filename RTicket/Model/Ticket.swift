//
//  Ticket.swift
//  RTicket
//
//  Created by Peter Loux on 6/28/24.
//

import Foundation
import RealmSwift
import SwiftUI

class Ticket: Object, ObjectKeyIdentifiable {
    @Persisted (primaryKey: true) var _id: ObjectId
    @Persisted var product: String
    @Persisted var title: String
    @Persisted var details: String?
    @Persisted var author: String
    @Persisted var created = Date()
    @Persisted var status = TicketStatus.notStarted
    var color: Color {
        switch status {
        case .notStarted:
            return .red
        case .inProgress:
            return .yellow
        case .complete:
            return .green
        }
    }
    
    enum TicketStatus: Int, PersistableEnum {
        case notStarted
        case inProgress
        case complete
    }
    
}
