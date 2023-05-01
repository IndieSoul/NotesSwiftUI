//
//  NotesSwiftUIApp.swift
//  NotesSwiftUI
//
//  Created by Luis Enrique Rosas Espinoza on 20/04/23.
//

import SwiftUI

@main
struct NotesSwiftUIApp: App {
    @StateObject private var viewModel = ViewModel()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
        }
    }
}
