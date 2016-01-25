//
//  DataService.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/25/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import Foundation

import Firebase

let URL_BASE = Keys.FireBaseKey

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_COMPARENDOS = Firebase(url: "\(URL_BASE)/comparendos")
    private var _REF_SALARIOS = Firebase(url: "\(URL_BASE)/salarios")
    
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_COMPARENDOS: Firebase {
        return _REF_COMPARENDOS
    }
    
    var REF_SALARIOS: Firebase {
        return _REF_SALARIOS
    }
    
    
    
    
}