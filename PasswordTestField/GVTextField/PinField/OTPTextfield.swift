//
//  OTPTextfield.swift
//  bank42
//
//  Created by Gagan Vishal on 2020/03/10.
//  Copyright © 2020 Meniga. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardDeleteDelegate {
    func deleteButtonPressed()
}

class OTPTextfield: UITextField {
    //
    var delegateDelete : KeyboardDeleteDelegate?
    //Border and text color
    var borderColor: UIColor  = UIColor.gray {
        didSet {
            resetBorderColor()
        }
    }
    
    //MARK:- View life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        createStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resetFrame()
    }
    
    //MARK:- Textfield framing
    fileprivate func resetFrame() {
        if let superViewObj = self.superview {
            heightAnchor.constraint(equalTo: superViewObj.heightAnchor, multiplier: 0.95).isActive = true
        }
    }
    
    //MARK:- Textfield border color
   fileprivate func resetBorderColor() {
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = 1.0
        textColor = self.borderColor
    }
    
    //MARK:- Textfield styling
    fileprivate func createStyle(){
        layer.cornerRadius = 6.0
        borderStyle = .roundedRect
        textAlignment = .center
        textColor = .blue
        isSecureTextEntry = true
        keyboardType = .numberPad
        resetBorderColor()
    }
    
    //MARK:- Back/Delete button action
    override func deleteBackward() {
        delegateDelete?.deleteButtonPressed()
    }

    //MARK:- Active Textfield
    func focus() {
        self.borderColor = UIColor.blue
    }
    
    //MARK:- Inactive Textfield
    func blur() {
        self.borderColor = UIColor.lightGray
    }
}
