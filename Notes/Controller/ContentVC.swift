//
//  ContentVC.swift
//  Notes
//
//  Created by William Yeung on 8/31/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {
    // MARK: - Subviews
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "August 30, 2020, 5:48 PM"
        label.textAlignment = .center
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
