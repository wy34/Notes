//
//  NotesVC.swift
//  Notes
//
//  Created by William Yeung on 8/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class NotesVC: UITableViewController {
    // MARK: - Subviews
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavbar()
        configToolbar()
        configTableView()
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
        toolbarItems = [space, composeButton]
    }
    
    // MARK: - Tableview
    func configTableView() {
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Note")
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    // MARK: - Selector
    @objc func editPressed() {
        
    }
    
    @objc func composeNewNote() {
        
    }
}

// MARK: - UITableView Delegate/Datasource
extension NotesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = "note"
        cell.backgroundColor = .tertiarySystemBackground
        return cell
    }
}
