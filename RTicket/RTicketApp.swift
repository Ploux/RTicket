//
//  RTicketApp.swift
//  RTicket
//
//  Created by Peter Loux on 6/28/24.
//

import SwiftUI
import RealmSwift

let realmApp = RealmSwift.App(id: "application-0-rwemjom")
@main
struct RTicketApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
