//
//  ConComparendosVC.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/27/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class ConComparendosVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtnClicked(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
   

}
