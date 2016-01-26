//
//  ComparendoListVC.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/25/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import Foundation

import UIKit
import Firebase

class ComparendoListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var inSearchMode = false
    var comparendos = [Comparendo]()
    var filteredArray = [Comparendo]()
    var SMDLV = 0
    var SMMLV = 0
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        searchBar.enablesReturnKeyAutomatically = false
        //tableView.estimatedRowHeight = 60
        
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
             self.tableView.reloadData()
        })
        
        DataService.ds.REF_SALARIOS.observeEventType(.Value, withBlock: { snapshot in
            if let salariosDict = snapshot.value {
                self.SMDLV = salariosDict["SMDLV"] as! Int
                self.SMMLV = salariosDict["SMMLV"] as! Int
            }
        })

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredArray = comparendos.filter({$0.description.lowercaseString.rangeOfString(lower) != nil})
        }
        self.tableView.reloadData()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let comparendo: Comparendo!
        
        if inSearchMode {
            comparendo = filteredArray[indexPath.row]
        } else {
            comparendo = comparendos[indexPath.row]
        }
        
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(("ComparendoCell")) as? ComparendoCell {
            cell.configureCell(comparendo)
            return cell
        } else {
            let cell = ComparendoCell()
            cell.configureCell(comparendo)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ComparendoDetailVC", sender: comparendos[indexPath.row])
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredArray.count
        }
        
        return comparendos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ComparendoDetailVC" {
            if let detailVC = segue.destinationViewController as? ComparendoDetailVC {
                if let comparendo = sender as? Comparendo {
                    detailVC.comparendo = comparendo
                    detailVC.SMDLV = self.SMDLV
                    detailVC.SMMLV = self.SMMLV
                }
            }
        }
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}
