//
//  TipCalculatorApp.swift
//  TipCalculator
//
//  Created by Michael DiGregorio on 1/15/22.
//

import SwiftUI

@main
struct TipCalculatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
