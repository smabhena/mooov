//
//  UIButtonExtension.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/07.
//

import Foundation
import UIKit

extension UIButton {
    func setCustomButtonStyling() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryColor.cgColor
    }
    
    func disableButton(_ disabaledTextLabel: String) {
        self.isEnabled = false
        self.setTitle(disabaledTextLabel, for: .disabled)
        self.setTitle("Saved", for: .disabled)
    }
}
