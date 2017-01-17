//
//  PinField.swift
//  PasswordTestField
//
//  Created by Gagan5278 on 16/01/17.
//  Copyright © 2017 Gagan. All rights reserved.
//

import UIKit
protocol KeyboardDeleteDelegate {
    func deleteButtonPressed()
}
class PinField: UITextField {

    var delegateDelete : KeyboardDeleteDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.isSecureTextEntry = true
        self.keyboardType = .numberPad
        self.textAlignment = .center
        self.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
        self.keyboardAppearance = .dark
        self.background = UIImage(named: "square_inactive")
        self.layer.borderWidth = 0.0
        self.text = ""
    }
    
    func carestRectForPosition(position : UITextPosition) -> CGRect
    {
        return CGRect.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func focus() {
        self.background = UIImage(named: "square_active")
        self.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
    }
    
    func blur() {
        self.background = UIImage(named: "square_inactive")
        self.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
    }
    
    func complete()
    {
        self.background = UIImage(named: "square_completed")
        self.textColor = UIColor.clear
    }

    func setErrorState (error : Bool)
    {
        self.layer.borderWidth = error ? 0.0 : 1.0
    }
    
    override func deleteBackward() {
        delegateDelete?.deleteButtonPressed()
    }
}
