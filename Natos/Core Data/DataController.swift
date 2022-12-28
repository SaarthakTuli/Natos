//
//  DataController.swift
//  Natos
//
//  Created by Saarthak Tuli on 28/12/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Note")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("ERROR: Unable to load container....\(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Save successful")
        } catch{
            print("ERROR: While saving.")
        }
    }
    
    func addNote(message: String, date: Date, color: String, context: NSManagedObjectContext) {
        let note = Note(context: context)
        
        note.id = UUID()
        note.message = message
        note.date = date
        note.color = color
        
        save(context: context)
    }
    
    func editNote(note: Note, message: String, date: Date, color: String, context: NSManagedObjectContext) {
        note.message = message
        note.date = date
        note.color = color
        
        save(context: context)
    }
    
    func deleteNote(note: Note, context: NSManagedObjectContext) {
        context.delete(note)
        
        save(context: context)
    }
}
