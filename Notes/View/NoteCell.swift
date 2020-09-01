//
//  NoteCell.swift
//  Notes
//
//  Created by William Yeung on 8/31/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    // MARK: - ReuseId
    static let reuseId = "NoteCell"
    
    // MARK: - Subviews
    private let mainPreviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Main Preview Title Main Preview Title Main Preview Title Main Preview Title"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "99/99/99"
        label.textColor = .systemGray
        return label
    }()
    
    private let secondaryPreviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Secondary Preview Label Secondary Preview Label Secondary Preview Label"
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var dateSecondaryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateLabel, secondaryPreviewLabel])
        dateLabel.setDimension(width: stack.widthAnchor, wMult: 0.25)
        return stack
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainPreviewLabel, dateSecondaryStack])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = -1
        return stack
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
        addSubview(contentStack)
        contentStack.setDimension(width: widthAnchor, wMult: 0.85)
        contentStack.anchor(top: topAnchor, bottom: bottomAnchor, paddingTop: 10, paddingBottom: 10)
        contentStack.center(to: self, by: .centerX, withMultiplierOf: 1.01)
    }
}
