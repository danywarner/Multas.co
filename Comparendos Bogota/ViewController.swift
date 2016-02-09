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

    var deviceVersion = 0
    var onlineVersion = 0
    var deviceHasOldDataVersion = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let flurryKey = Keys.FlurryKey
        Flurry.startSession(flurryKey);
        
        fetchVersion()
        checkDataVersion()
       
        
    }
    
    func checkDataVersion() {
        DataService.ds.REF_DATA_VERSION.observeEventType(.Value, withBlock: { snapshot in
            let onlineVersion = snapshot.value as! Int
            self.onlineVersion = onlineVersion
            
            if (self.onlineVersion > self.deviceVersion) {
                
                //self.deleteStoredDrugs()
                self.storeDeviceVersion(onlineVersion)
                self.deviceHasOldDataVersion = true
                
            } else {
                self.deviceHasOldDataVersion = false
            }
        })
    }
    
    func fetchVersion() {
        if let loadedVersion = NSUserDefaults.standardUserDefaults().valueForKey("version") as? Int {
            deviceVersion = loadedVersion
        }
    }
    
    func storeDeviceVersion(version: Int) {
         NSUserDefaults.standardUserDefaults().setValue(version, forKey: "version")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ComparendoListVC" {
            if let listVC = segue.destinationViewController as? ComparendoListVC {
                
                    listVC.deviceHasOldDataVersion = deviceHasOldDataVersion
                
                
                //listVC.transitioningDelegate = self.transitionManager
            }
        }
    }

    


}

