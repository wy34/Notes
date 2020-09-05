//
//  ContentVC.swift
//  Notes
//
//  Created by William Yeung on 8/31/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {
    // MARK: - Constants/Variables
    var parentFolder: Folder!
    var selectedNote: Note!
    
    var textInputStringComponents: [String] {
        if let textInput = textView.text {
            let separatedComponents = textInput.components(separatedBy: "\n")
            return separatedComponents
        }
        return [""]
    }
    
    var mainPreview: String {
        return textInputStringComponents[0]
    }
    
    var secondaryPreview: String {
        if textInputStringComponents.count > 1 {
            return textInputStringComponents[1]
        } else {
            return "No additional text"
        }
    }
    
    // MARK: - Subviews
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "August 30, 2020, 5:48 PM"
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.delegate = self
        return tv
    }()
    
    private lazy var doneBarButton: UIBarButtonItem = {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        return done
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        configNavbar()
        configToolbar()
        layoutSubviews()
        setDateTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayExistingNote()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if textView.text.isEmpty {
            textView.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if !textView.text.isEmpty && selectedNote == nil {
            CoreDataManager.shared.createNote(withContent: textView.text, mainPreview: mainPreview, andSecondaryPreview: secondaryPreview, inFolder: parentFolder)
        }
    }
    
    // MARK: - Navbar
    func configNavbar() {
        edgesForExtendedLayout = []
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = nil
    }
    
    // MARK: - Toolbar
    func configToolbar() {
        toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashPressed)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composePressed))
        ]
    }
    
    // MARK: - Layout
    func layoutSubviews() {
        view.addSubview(dateLabel)
        dateLabel.center(to: view, by: .centerX)
        dateLabel.anchor(top: view.topAnchor, right: view.rightAnchor, left: view.leftAnchor, paddingTop: 15, paddingRight: 18, paddingLeft: 18)
        
        view.addSubview(textView)
        textView.anchor(top: dateLabel.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingRight: 18, paddingBottom: 18, paddingLeft: 18)
    }
    
    // MARK: - Display existing note
    func displayExistingNote() {
        if let selectedNote = selectedNote {
            self.textView.text = selectedNote.fullContent
            setDateTime()
        }
    }
    
    // MARK: - Set Date and Time
    func setDateTime() {
        let dateTime = selectedNote != nil ? selectedNote.date : Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.string(from: dateTime!)
        
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: dateTime!)
        self.dateLabel.text = "\(date) at \(time)"
    }
    
    // MARK: - Selector
    @objc func donePressed() {
        textView.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc func trashPressed() {
        
    }
    
    @objc func sharePressed() {
        
    }
    
    @objc func composePressed() {
        
    }
}

// MARK: - UITextViewDelegate
extension ContentVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.5) {
            self.navigationItem.rightBarButtonItem = self.doneBarButton
        }
    }
}
