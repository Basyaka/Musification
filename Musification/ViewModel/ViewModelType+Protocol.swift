//
//  ViewModelType+Protocol.swift
//  LoginScreenMVVMRx
//
//  Created by Vlad Novik on 31.03.21.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
