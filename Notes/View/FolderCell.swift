//
//  FolderCell.swift
//  Notes
//
//  Created by William Yeung on 8/31/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class FolderCell: UITableViewCell {
    // MARK: - ReuseId
    static let reuseId = "FolderCell"
    
    // MARK: - Subviews
    private let folderNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Folder Name"
        return label
    }()
    
    private let folderIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "folder")
        iv.tintColor = .notesYellow
        return iv
    }()
    
    private let notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "19"
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .tertiarySystemBackground
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func layoutComponents() {
        addSubview(folderIcon)
        folderIcon.center(to: self, by: .centerY)
        folderIcon.center(to: self, by: .centerX, withMultiplierOf: 0.15)
        folderIcon.setDimension(width: heightAnchor, height: heightAnchor, wMult: 0.7, hMult: 0.55)
        
        addSubview(notesLabel)
        notesLabel.center(to: self, by: .centerY)
        notesLabel.anchor(left: folderIcon.rightAnchor, paddingLeft: 10)
        
        addSubview(countLabel)
        countLabel.center(to: self, by: .centerY)
        countLabel.anchor(right: rightAnchor, left: notesLabel.rightAnchor, paddingRight: 40, paddingLeft: 10)
    }
}
