//
//  NotesVC.swift
//  Notes
//
//  Created by William Yeung on 8/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import CoreData

class NotesVC: UITableViewController {
    // MARK: - Constants/Variables
    var request: NSFetchRequest<Note>?
    var fetchController: NSFetchedResultsController<Note>?
    var parentFolder: Folder!
    
    // MARK: - Subviews
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let noteCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "No Notes"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavbar()
        configToolbar()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchController()
        CoreDataManager.shared.loadNotes(withFetchController: fetchController!)
        noteCountLabel.text = noteCount()
    }
    
    // MARK: - Navbar
    func configNavbar() {
        title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // MARK: - Toolbar
    func configToolbar() {
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeNewNote))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let noteCountButton = UIBarButtonItem(customView: noteCountLabel)
        toolbarItems = [space, noteCountButton, space, composeButton]
    }
    
    // MARK: - Tableview
    func configTableView() {
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    // MARK: - Setup NSFetchResultsController
    func setupFetchController() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        request = Note.fetchRequest()
        request?.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request?.predicate = NSPredicate(format: "parentFolder.name MATCHES %@", parentFolder.name!)
        fetchController = NSFetchedResultsController(fetchRequest: request!, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController?.delegate = self
    }
    
    // MARK: - Counting the number of notes
    func noteCount() -> String {
        let noteCount = fetchController!.sections![0].numberOfObjects
        
        if noteCount == 0 {
            return "No Notes"
        } else if noteCount == 1 {
            return "\(noteCount) Note"
        } else {
            return "\(noteCount) Notes"
        }
    }
    
    // MARK: - Selector
    @objc func editPressed() {
        
    }
    
    @objc func composeNewNote() {
        let contentVC = ContentVC()
        contentVC.parentFolder = parentFolder
        navigationController?.pushViewController(contentVC, animated: true)
    }
}

// MARK: - UITableView Delegate/Datasource
extension NotesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = fetchController?.sections?[section].numberOfObjects else { return 0 }
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        cell.note = fetchController?.object(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentVC = ContentVC()
        contentVC.selectedNote = fetchController?.object(at: indexPath)
        navigationController?.pushViewController(contentVC, animated: true)
    }
}

// MARK: - NSFetchResultsControllerDelegate
extension NotesVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                if let newIndexPath = newIndexPath {
                    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            case .delete:
                if let indexPath = indexPath {
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            default:
                break
        }
    }
}
