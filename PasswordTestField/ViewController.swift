//
//  ViewController.swift
//  PasswordTestField
//
//  Created by Gagan5278 on 16/01/17.
//  Copyright © 2017 Gagan. All rights reserved.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pinFileldsContainerView: PinContainerStackView!
    
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        pinFileldsContainerView.registerDelegate = self
    }
}


//MARK: RegisterSecondaryDevice Delegate
extension ViewController: RegisterSecondaryDevice {
    func registerSecondaryDevice(with token: String) {
           /*
          send to server or process locally
        */
          print("token is :\(token)")
    }

}
