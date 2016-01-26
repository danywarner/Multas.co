//
//  Comparendo.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/25/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import Foundation


class Comparendo {
    private var _code: String!
    private var _description: String!
    private var _SMDLVValue: Int!
    private var _towedAway: Bool?
    
    var code: String {
        get {
            return _code
        }
        set {
            _code = newValue
        }
    }
    
    var description: String! {
        get {
            if _description == nil {
                _description = ""
            }
            
            return _description
        }
        set {
            _description = newValue
        }
    }
    
    var SMDLVValue: Int! {
        get {
            if _SMDLVValue == nil {
                _SMDLVValue = 0
            }
            return _SMDLVValue!
        }
    }
    
    var towedAway: Bool! {
        get {
            if _towedAway == nil {
                _towedAway = false
            }
            return _towedAway!
        }
    }
    
    
    init(code: String) {
        _code = code
    }
    
    init(code: String, dictionary: Dictionary<String, AnyObject>) {
        self._code = code
        
        _description = ""
        _SMDLVValue = 0
        _towedAway = false
        
        // print(dictionary.debugDescription)
        if let code = dictionary["codigo"] as? String {
            
                _code = code
        }
        
        if let description = dictionary["descripcion"] as? String {
            
            _description = description
        }
        
        
        
        if let SMDLVValue = dictionary["valorSMDLV"] as? Int {
            
            _SMDLVValue = SMDLVValue
        }
        
        if let towedAway = dictionary["inmovilizable"] as? Int {
            
            if towedAway == 0 {
                _towedAway = false
            } else if towedAway == 1 {
                _towedAway = true
            }
        }
        
    }
    
}