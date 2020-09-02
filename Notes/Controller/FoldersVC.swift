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
    var fetchController: NSFetchedResultsController<Folder>?
    var newFolderTextField: UITextField!
    var saveAction: UIAlertAction!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavbar()
        configToolbar()
        configTableView()
        CoreDataManager.shared.loadFolders()
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
        tableView.register(FolderNameCell.self, forCellReuseIdentifier: FolderNameCell.reuseId)
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
//        let c =  fetchController?.sections![section].objects?.count
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        
        if indexPath.row % 2 != 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.reuseId, for: indexPath) as! FolderCell
            cell.accessoryType = .disclosureIndicator
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: FolderNameCell.reuseId, for: indexPath) as! FolderNameCell
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.row % 2 == 0 ? nil : indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notesVC = NotesVC()
        navigationController?.pushViewController(notesVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? 50 : 45
    }
}
