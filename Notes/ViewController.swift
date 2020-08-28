//
//  ViewController.swift
//  Notes
//
//  Created by William Yeung on 8/25/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavbar()
        
        tableView.backgroundColor = .tertiarySystemBackground
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
    
    // MARK: - Selector
    @objc func editPressed() {
        print("Edit pressed")
    }

}

