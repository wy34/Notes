//
//  ViewController.swift
//  Notes
//
//  Created by William Yeung on 8/25/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class FoldersVC: UITableViewController {
    // MARK: - Constants/Variables
    var newFolderTextField: UITextField!
    var saveAction: UIAlertAction!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavbar()
        configToolbar()
        configTableView()
    }
    
    // MARK: - Config Navbar
    func configNavbar() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        appearance.backgroundColor = .tertiarySystemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationItem.title = "Folders"
        navigationController?.navigationBar.tintColor = .systemGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
    }
    
    // MARK: - Config Toolbar
    func configToolbar() {
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = UIColor.notesYellow
        toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "New Folder", style: .plain, target: self, action: #selector(newFolderPressed))
        ]
    }
    
    // MARK: - Config TableView
    func configTableView() {
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Folder")
    }

    // MARK: - Config NewFolderTextField
    func configure(newFolderTextField: UITextField) {
        self.newFolderTextField = newFolderTextField
        newFolderTextField.placeholder =  "Name"
        newFolderTextField.clearButtonMode = .whileEditing
        newFolderTextField.addTarget(self, action: #selector(enableSaveFolder), for: .editingChanged)
    }

    // MARK: - Selector
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
        saveAction = UIAlertAction(title: "Save", style: .default, handler: nil)
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Folder", for: indexPath)
        cell.backgroundColor = .tertiarySystemBackground
        cell.textLabel?.text = "row"
        return cell
    }
}
