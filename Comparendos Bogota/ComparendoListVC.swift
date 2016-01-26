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
    var secciones = [String]()
    var comparendosTemp = [Comparendo]()
    var comparendosPorSeccion = [[Comparendo]]()
    var filteredArray = [[Comparendo]]()
    var SMDLV = 0
    var SMMLV = 0
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        searchBar.enablesReturnKeyAutomatically = false
        //tableView.estimatedRowHeight = 60
        
        DataService.ds.REF_NOMBRE_SECCIONES.observeEventType(.Value, withBlock: { snapshot in
            
            
            self.secciones = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    let value = snap.value
                    self.secciones.append(value as! String)
                }
            }
            self.tableView.reloadData()
        })
        
        
        DataService.ds.REF_SECCIONES.observeEventType(.Value, withBlock: { snapshot in
            
            
            self.comparendosPorSeccion = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    self.comparendosTemp = []
                    if let comparendoDict = snap.value as? Dictionary<String, AnyObject> {
                       // let key = snap.key
                        let code = comparendoDict["codigo"] as! String
                        let comparendosArray = comparendoDict["comparendos"] as! Array<Dictionary<String, AnyObject>>
                        for var k=0 ; k < comparendosArray.count ; k++ {
                            let comparendo = Comparendo(code: code, dictionary: comparendosArray[k])
                            self.comparendosTemp.append(comparendo)
                        }
                        self.comparendosPorSeccion.append(self.comparendosTemp)
                        
                        
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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
        if searchBar.text != "" {
            searchBar.text = ""
        }
        inSearchMode = false
        tableView.reloadData()
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searchBar.showsCancelButton = false
            inSearchMode = false
            view.endEditing(true)
        } else {
            searchBar.showsCancelButton = true
            inSearchMode = true
            filteredArray = []
            let lower = searchBar.text!.lowercaseString
            for var k = 0 ; k < comparendosPorSeccion.count ; k++ {
                filteredArray.append(comparendosPorSeccion[k].filter({$0.description.lowercaseString.rangeOfString(lower, options: NSStringCompareOptions.DiacriticInsensitiveSearch, range: nil, locale: nil) != nil}))
            }
            
        }
        self.tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            return secciones[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return secciones.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionTitle: String = self.tableView(tableView, titleForHeaderInSection: section)!
        if sectionTitle == "" {
            return nil
        }
        
        let title: UILabel = UILabel()
        
        title.text = sectionTitle
        title.textColor = UIColor(red: 0.0, green: 0.54, blue: 0.0, alpha: 0.8)
        title.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        title.font = UIFont.boldSystemFontOfSize(15)
        title.numberOfLines = 0
        title.textAlignment = NSTextAlignment.Center
        title.lineBreakMode = NSLineBreakMode.ByWordWrapping
        title.sizeToFit()
        
        return title
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let comparendo: Comparendo!
        
        if inSearchMode {
            comparendosTemp = filteredArray[indexPath.section]
            comparendo = comparendosTemp[indexPath.row]
        } else {
            comparendosTemp = comparendosPorSeccion[indexPath.section]
            comparendo = comparendosTemp[indexPath.row]
        }
        
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(("ComparendoCell")) as? ComparendoCell {
            cell.configureCell(comparendo)
            return cell
        } else {
            let cell = ComparendoCell()
            cell.configureCell(comparendo)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if inSearchMode {
            comparendosTemp = filteredArray[indexPath.section]
        } else {
            comparendosTemp = comparendosPorSeccion[indexPath.section]
        }
        performSegueWithIdentifier("ComparendoDetailVC", sender: comparendosTemp[indexPath.row])
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredArray[section].count
        }
        if comparendosPorSeccion.count > 0 {
            return comparendosPorSeccion[section].count
        } else {
            return 0
        }
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
