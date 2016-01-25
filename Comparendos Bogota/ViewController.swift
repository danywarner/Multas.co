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

    var SMDLV = 0
    var SMMLV = 0
    var comparendos = [Comparendo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flurryKey = Keys.FlurryKey
        Flurry.startSession(flurryKey);// development
        
        DataService.ds.REF_SALARIOS.observeEventType(.Value, withBlock: { snapshot in
            if let salariosDict = snapshot.value {
                self.SMDLV = salariosDict["SMDLV"] as! Int
                self.SMMLV = salariosDict["SMMLV"] as! Int
            }
        })
        
        DataService.ds.REF_COMPARENDOS.observeEventType(.Value, withBlock: { snapshot in
            
            self.comparendos = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let comparendoDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let comparendo = Comparendo(code: key, dictionary: comparendoDict)
                        self.comparendos.append(comparendo)
                        
                    }
                }
            }
           // self.collection.reloadData()
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

