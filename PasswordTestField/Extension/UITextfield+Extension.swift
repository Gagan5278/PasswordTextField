//
//  UITextfield+Extension.swift
//  PasswordTestField
//
//  Created by Gagan  Vishal on 3/17/20.
//  Copyright © 2020 Gagan. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    //MARK: Add done button on Keyborad
    func addToolbarWithNextButton(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(nextButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .blackTranslucent
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        toolbar.layoutIfNeeded()
        self.inputAccessoryView = toolbar
    }
    
    @objc func nextButtonTapped() {
        self.resignFirstResponder()
    }
    
}
