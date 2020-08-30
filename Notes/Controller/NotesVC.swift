//
//  NotesVC.swift
//  Notes
//
//  Created by William Yeung on 8/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class NotesVC: UITableViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavbar()
    }
    
    // MARK: - Navbar
    func configNavbar() {
        title = "Notes"
    }
}
