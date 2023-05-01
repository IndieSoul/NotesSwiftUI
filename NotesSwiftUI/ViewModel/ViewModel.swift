//
//  ViewModel.swift
//  NotesSwiftUI
//
//  Created by Luis Enrique Rosas Espinoza on 22/04/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var note = ""
    @Published var date = Date()
    @Published var show = false
    @Published var updateItem: Notes!
    
    func saveData(context: NSManagedObjectContext) {
        let newNote = Notes(context: context)
        newNote.note = note
        newNote.date = date
        newNote.id = UUID()
        
        do {
            try context.save()
            print("save")
            show.toggle()
        } catch let error as NSError {
            print("Not save \(error.localizedDescription)")
        }
    }
    
    func deleteData(item: Notes, context: NSManagedObjectContext) {
        context.delete(item)
        do {
            try context.save()
            print("Delete")
        } catch let error as NSError {
            print("Not delete \(error.localizedDescription)")
        }
    }
    
    func sendItem(item: Notes) {
        updateItem = item
        note = item.note ?? ""
        date = item.date ?? Date()
        updateItem.id = item.id
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext) {
        updateItem.date = date
        updateItem.note = note
        do {
            try context.save()
            print("Edit complete")
            show.toggle()
        } catch let error as NSError {
            print("No edit", error.localizedDescription)
        }
    }
}
