//
//  ValidateParameters.swift
//  LoginScreenMVVMRx
//
//  Created by Vlad Novik on 31.03.21.
//

import Foundation

class ValidateParameters {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=[a-zA-Z0-9._]{8,}$)(?!.*[_.]{2})[^_.].*[^_.]$")
        return passwordTest.evaluate(with: password)
    }
    
    static func isEmailValid(_ email: String) -> Bool {
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")
        return emailTest.evaluate(with: email)
    }
}
