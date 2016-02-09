//
//  Comparendo.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/25/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import Foundation


class Comparendo: NSObject, NSCoding {
    private var _code: String!
    private var _comparendoDescription: String!
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
    
    var comparendoDescription: String! {
        get {
            if _comparendoDescription == nil {
                _comparendoDescription = ""
            }
            
            return _comparendoDescription
        }
        set {
            _comparendoDescription = newValue
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
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._code = aDecoder.decodeObjectForKey("code") as? String
        self._comparendoDescription = aDecoder.decodeObjectForKey("description") as? String
        self._SMDLVValue = aDecoder.decodeObjectForKey("SMDLVValue") as? Int
        self._towedAway = aDecoder.decodeObjectForKey("towedAway") as? Bool
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._code, forKey: "code")
        aCoder.encodeObject(self._comparendoDescription, forKey: "description")
        aCoder.encodeObject(self._SMDLVValue, forKey: "SMDLVValue")
        aCoder.encodeObject(self._towedAway, forKey: "towedAway")
    }
    
    init(code: String) {
        _code = code
    }
    
    init(code: String, dictionary: Dictionary<String, AnyObject>) {
        
        _code = code
        _comparendoDescription = ""
        _SMDLVValue = 0
        _towedAway = false
        
        // print(dictionary.debugDescription)
        if let code = dictionary["codigo"] as? String {
            
                _code = code
        }
        
        if let description = dictionary["descripcion"] as? String {
            
            _comparendoDescription = description
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