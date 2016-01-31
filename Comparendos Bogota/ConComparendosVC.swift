//
//  ConComparendosVC.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/27/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class ConComparendosVC: UIViewController {

    @IBOutlet weak var estadoLbl: UILabel!
    @IBOutlet weak var numeroLbl: UILabel!
    @IBOutlet weak var placaLbl: UILabel!
    @IBOutlet weak var fechaLbl: UILabel!
    @IBOutlet weak var saldoLbl: UILabel!
    @IBOutlet weak var interesesLbl: UILabel!
    @IBOutlet weak var saldoMasInteresesLbl: UILabel!
    @IBOutlet weak var descuentoLey1450Lbl: UILabel!
   
    
    
    
    
    private var _comparendoExistente: ComparendoExistente!
    
    var comparendoExistente: ComparendoExistente {
        get {
            return _comparendoExistente
        }
        set {
            _comparendoExistente = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        estadoLbl.text = "\(_comparendoExistente.estado)"
        numeroLbl.text = "\(_comparendoExistente.numero)"
        placaLbl.text = "\(_comparendoExistente.placa)"
        fechaLbl.text = "\(_comparendoExistente.fecha)"
        saldoLbl.text = "\(_comparendoExistente.saldo)"
        interesesLbl.text = "\(_comparendoExistente.intereses)"
        saldoMasInteresesLbl.text = "\(_comparendoExistente.saldoMasIntereses)"
        descuentoLey1450Lbl.text = "\(_comparendoExistente.descuentoLey1450)"
        
    }
 
   
    

    @IBAction func backBtnClicked(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
   

}
