//
//  ConsultaVC.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/26/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import Alamofire

class ConsultaVC: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    typealias DownloadComplete = () -> ()
    
    var url2 = "http://consultas.transitobogota.gov.co:8083/consultas_generales/buscar_comparendos.php?datos_enviados=S&tipo_documento=1&numero_identificacion=&placa_veh=gld591&tipo_busqueda=BC&existe_financiacion_finan=0&existe_financiacion_acpag=0"
    
    var url1 = "http://consultas.transitobogota.gov.co:8083/consultas_generales/buscar_comparendos.php?datos_enviados=S&tipo_documento=1&numero_identificacion=1014192693&placa_veh=&pagina_actual=1&tipo_busqueda=BC&existe_financiacion_finan=0&existe_financiacion_acpag=0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    
    
    
    @IBAction func queryButtonPressed(sender: AnyObject) {
        
        self.queryForComparendos { () -> () in
            
        }
        
    }
    
    func queryForComparendos(completed: DownloadComplete) {
        let url = NSURL(string: url1)!
        Alamofire.request(.GET, url).responseString { (response) -> Void in
            let result = response.result
            if result.value.debugDescription.rangeOfString("VIGENTE") != nil{
                print("hay uno!")
            } else {
                print("no hay")
            }
           // print(result.value.debugDescription)
        }
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }


}
