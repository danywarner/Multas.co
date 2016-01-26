//
//  ViewController.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/25/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import Flurry_iOS_SDK
import Firebase

class ViewController: UIViewController {

       
    override func viewDidLoad() {
        super.viewDidLoad()
        let flurryKey = Keys.FlurryKey
        Flurry.startSession(flurryKey);
        
        
        
    }

    


}

