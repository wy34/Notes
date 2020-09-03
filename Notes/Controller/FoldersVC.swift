//
//  ViewController.swift
//  Notes
//
//  Created by William Yeung on 8/25/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import CoreData

class FoldersVC: UITableViewController {
    // MARK: - Constants/Variables
    var request: NSFetchRequest<Folder>?
    var fetchController: NSFetchedResultsController<Folder>?
    var newFolderTextField: UITextField!
    var saveAction: UIAlertAction!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavbar()
        configToolbar()
        configTableView()
        setupFetchController()
        CoreDataManager.shared.loadFolders(withFetchController: fetchController!)
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    // MARK: - Navbar
    func configNavbar() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        appearance.backgroundColor = .tertiarySystemBackground
        appearance.shadowColor = .clear
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationItem.title = "Folders"
        navigationController?.navigationBar.tintColor = .notesYellow
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Toolbar
    func configToolbar() {
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = UIColor.notesYellow
        navigationController?.toolbar.barTintColor = .tertiarySystemBackground
        navigationController?.toolbar.isTranslucent = false
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "New Folder", style: .plain, target: self, action: #selector(newFolderPressed))
        ]
    }
    
    // MARK: - TableView
    func configTableView() {
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.register(FolderCell.self, forCellReuseIdentifier: FolderCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        tableView.tableHeaderView = view
    }

    // MARK: - Config NewFolderTextField
    func configure(newFolderTextField: UITextField) {
        self.newFolderTextField = newFolderTextField
        newFolderTextField.placeholder =  "Name"
        newFolderTextField.clearButtonMode = .whileEditing
        newFolderTextField.addTarget(self, action: #selector(enableSaveFolder), for: .editingChanged)
    }
    
    // MARK: - Setup NSFetchResultsController
    func setupFetchController() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        request = Folder.fetchRequest()
        request?.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchController = NSFetchedResultsController(fetchRequest: request!, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController?.delegate = self
    }

    // MARK: - Selector Methods
    @objc func editPressed() {
        print("Edit pressed")
    }
    
    @objc func newFolderPressed() {
        let alertController = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
        alertController.view.tintColor = UIColor.notesYellow

        alertController.addTextField { (tf) in
            self.configure(newFolderTextField: tf)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            CoreDataManager.shared.createFolder(withName: self.newFolderTextField.text, andCount: 0)
        }

        saveAction.isEnabled = false

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }

    @objc func enableSaveFolder() {
        saveAction.isEnabled = newFolderTextField.text?.trimmingCharacters(in: .whitespaces) != "" ? true : false
    }
}

// MARK: - UITableViewController Delegate/Datasource Methods
extension FoldersVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = fetchController?.sections?[section].numberOfObjects else { return 0 }
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.reuseId, for: indexPath) as! FolderCell
        cell.folder = fetchController?.object(at: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notesVC = NotesVC()
        navigationController?.pushViewController(notesVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            if let folderToDelete = self.fetchController?.object(at: indexPath) {
                CoreDataManager.shared.delete(folder: folderToDelete)
                completion(true)
                // not deleting from sqlite
            }
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - NSFetchResultsControllerDelegate
extension FoldersVC: NSFetchedResultsControllerDelegate {
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
