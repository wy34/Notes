//
//  FolderNameCell.swift
//  Notes
//
//  Created by William Yeung on 8/31/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class FolderNameCell: UITableViewCell {
    // MARK: - ResuseId
    static let reuseId = "FolderNameCell"
    
    // MARK: - Subviews
    private let cellNameLabel: UILabel = {
        let label = UILabel()
        label.text = "NameOfFolder"
        label.textColor = .systemGray
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
        addSubview(cellNameLabel)
        cellNameLabel.center(to: self, by: .centerX, withMultiplierOf: 0.37)
        cellNameLabel.anchor(bottom: bottomAnchor, paddingBottom: 5)
    }
}
