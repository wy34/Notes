//
//  CoreDataManager.swift
//  Notes
//
//  Created by William Yeung on 9/1/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    

    func save(withContext context: NSManagedObjectContext) {
        do {
            try? context.save()
        }
    }

    func createFolder(withName name: String?) {
        guard let folderName = name else { return }
        let folder = Folder(context: context!)
        folder.name = folderName
        save(withContext: context!)
    }
    
    func loadFolders(withFetchController controller: NSFetchedResultsController<Folder>) {
        do {
            try? controller.performFetch()
        }
    }
    
    func delete(folder: Folder? = nil, note: Note? = nil) {
        if let folder = folder {
            context?.delete(folder)
        }
        if let note = note {
            context?.delete(note)
        }
        save(withContext: context!)
    }
    
    func createNote(withContent c: String, mainPreview mp: String, andSecondaryPreview sp: String, inFolder folder: Folder) {
        let note = Note(context: context!)
        note.fullContent = c
        note.mainPreview = mp
        note.secondaryPreview = sp
        note.date = Date()
        note.parentFolder = folder
        save(withContext: context!)
    }
    
    func loadNotes(withFetchController controller: NSFetchedResultsController<Note>) {
        do {
            try? controller.performFetch()
        }
    }
}
