//
//  ConsultaVC.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/26/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import Alamofire

class ConsultaVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var DocPicker: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    typealias DownloadComplete = () -> ()
    
    var baseString = "http://consultas.transitobogota.gov.co:8083/consultas_generales/buscar_comparendos.php?"
    var datosEnviados = "datos_enviados=S"
    var tipoDocumento = "tipo_documento="
    var numeroIdentificacion = "numero_identificacion="
    var placaVeh = "placa_veh="
    var tipoBusqueda = "tipo_busqueda=BC"
    var urlString = ""
    let pickerData = [["Cédula de ciudadanía", "Placa Vehículo", "N.I.T.", "Cédula de extranjería","Tarjeta de identidad", "Pasaporte","Registro civil","Servitecas", "Carnet diplomático"]]
    
    enum documentTypes:Int{
        case cedulaCiudadania = 1
        case nit = 2
        case cedulaExtranjeria = 3
        case tarjetaIdentidad = 4
        case pasaporte = 5
        case registroCivil = 6
        case servitecas = 7
        case carnetDiplomatico = 8
    }
    
//    var url1 = "http://consultas.transitobogota.gov.co:8083/consultas_generales/buscar_comparendos.php?datos_enviados=S&tipo_documento=1&numero_identificacion=1014192693&placa_veh=&pagina_actual=1&tipo_busqueda=BC&existe_financiacion_finan=0&existe_financiacion_acpag=0"
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        DocPicker.delegate = self
        DocPicker.dataSource = self
        textField.delegate = self
        DocPicker.selectRow(0, inComponent: 0, animated: false)
        printPickerData()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let docTypesArray = pickerData[0]
        if docTypesArray.indexOf(pickerData[0][DocPicker.selectedRowInComponent(0)]) == 1 {
            textField.keyboardType = UIKeyboardType.Alphabet
        } else {
            textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        }
        
        printPickerData()
    }
    
    func printPickerData() {
        print(pickerData[0][DocPicker.selectedRowInComponent(0)])
    }
    
    @IBAction func queryButtonPressed(sender: AnyObject) {
        
        self.queryForComparendos { () -> () in
            
        }
        
    }
    
    func queryForComparendos(completed: DownloadComplete) {
        let docTypesArray = pickerData[0]
        placaVeh = "placa_veh="
        tipoDocumento = "tipo_documento="
        numeroIdentificacion = "numero_identificacion="
        
        
        let index = docTypesArray.indexOf(pickerData[0][DocPicker.selectedRowInComponent(0)])! + 1
        let indexStr = String(index)
        
        
        if index != 2 {
            if let document = textField.text {
                tipoDocumento.appendContentsOf(indexStr)
                numeroIdentificacion.appendContentsOf(document)
            }
            
        } else {
            if let placa = textField.text{
                
                let trimmedString = placa.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                placaVeh.appendContentsOf(trimmedString)
            }
        }
        
        
        
        urlString = "\(baseString)\(datosEnviados)&\(tipoDocumento)&\(numeroIdentificacion)&\(placaVeh)&\(tipoBusqueda)"
        print(urlString)
        let url = NSURL(string: urlString)!
        Alamofire.request(.GET, url).responseString { (response) -> Void in
            let result = response.result
            if result.value.debugDescription.lowercaseString.rangeOfString("no se encontraron registros de comparendos") != nil{
                print("no hay!")
                self.performSegueWithIdentifier("SinComparendosVC", sender: "")
            } else {
                print("tiene comparendos")
                self.performSegueWithIdentifier("ConComparendosVC", sender: "")

            }
           // print(result.value.debugDescription)
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        queryButtonPressed(self.view)
        return false
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }


}
