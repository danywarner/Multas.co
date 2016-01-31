//
//  ComparendoDetailVC.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/25/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit


class ComparendoDetailVC: UIViewController {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var fiftyPercentLabel: UILabel!
    @IBOutlet weak var seventyfivePercentLabel: UILabel!
    @IBOutlet weak var smdlvValue: UILabel!
    @IBOutlet weak var smdlvInCash: UILabel!
    @IBOutlet weak var towedAwayLbl: UILabel!
    
    
    
    
    
    private var _comparendo: Comparendo!
    var SMMLV = 0
    var SMDLV = 0
    var comparendoTotal = 0.0
    
    var comparendo: Comparendo {
        get {
            return _comparendo
        }
        set {
            _comparendo = newValue
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        comparendoTotal = Double(comparendo.SMDLVValue!*self.SMDLV)
        codeLabel.text = comparendo.code
        descriptionLabel.text = comparendo.description
        totalPriceLabel.text = "$\(comparendoTotal)"
        fiftyPercentLabel.text = "$\(comparendoTotal/2)"
        seventyfivePercentLabel.text = "$\(comparendoTotal*0.75)"
        smdlvValue.text = "\(comparendo.SMDLVValue)"
        smdlvInCash.text = "$\(self.SMDLV)"
        
        if comparendo.towedAway == false {
            towedAwayLbl.text = "No"
        } else {
            towedAwayLbl.text = "Sí"
        }
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
}