//
//  ComparendoExistente.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/31/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import Foundation

class ComparendoExistente {
    private var _estado: String!
    private var _numero: String!
    private var _placa: String!
    private var _fecha: String!
    private var _saldo: String!
    private var _intereses: String!
    private var _saldoMasIntereses: String!
    private var _descuentoLey1450: String!
    
    var estado: String! {
        get {
            return _estado
        }
    }
    
    var numero: String! {
        get {
            return _numero
        }
    }
    
    var placa: String! {
        get {
            return _placa
        }
    }
    
    var fecha: String! {
        get {
            return _fecha
        }
    }
    
    var saldo: String! {
        get {
            return _saldo
        }
    }
    
    var intereses: String! {
        get {
            return _intereses
        }
    }
    
    var saldoMasIntereses: String! {
        get {
            return _saldoMasIntereses
        }
    }
    
    var descuentoLey1450: String! {
        get {
            return _descuentoLey1450
        }
    }
    
    
    
    
    init(estado: String, numero: String, placa: String, fecha: String, saldo: String, intereses: String, saldoMasIntereses: String, descuentoLey1450: String) {
        
        _estado = estado
        _numero = numero
        _placa = placa
        _fecha = fecha
        _saldo = saldo
        _intereses = intereses
        _saldoMasIntereses = saldoMasIntereses
        _descuentoLey1450 = descuentoLey1450
        
    }
    
    
}