//
//  UIColor.swift
//  Notes
//
//  Created by William Yeung on 8/27/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

extension UIColor {
    static let notesYellow = UIColor(rgb: 0xE0BE53)
    
    convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat((rgb >> 0) & 0xFF) / 255,
            alpha: 1
        )
    }
}
