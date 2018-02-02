//
//  ViewController.swift
//  PasswordTestField
//
//  Created by Gagan5278 on 16/01/17.
//  Copyright © 2017 Gagan. All rights reserved.
//


import UIKit

let numberOfTextFields = 5   //Set your number of textfields here


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Set your height & width here
        self.view.backgroundColor = UIColor(red: 62.0/256.0, green: 152.0/256.0, blue: 229.0/256.0, alpha: 1)
        //Add This code
        let pinView  = PinView(frame : CGRect(x: 0, y: 150, width: UIScreen.main.bounds.size.width, height: 100))
        self.view.addSubview(pinView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

