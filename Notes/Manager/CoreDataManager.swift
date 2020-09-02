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
    var fetchController: NSFetchedResultsController<Folder>!

    func save(withContext context: NSManagedObjectContext) {
        do {
            try? context.save()
        }
    }

    func createFolder(withName name: String?, andCount count: Int) {
        guard let folderName = name else { return }
        let folder = Folder(context: context!)
        folder.name = folderName
        folder.noteCount = Int64(count)
        save(withContext: context!)
    }
    
    func loadFolders() {
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try? fetchController.performFetch()
        }
    }
}
