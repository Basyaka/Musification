//
//  LoginViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    
    private let bag = DisposeBag()
    
    let signUpTapPublishSubject = PublishSubject<Void>()
    let passwordRecoveryTap = PublishSubject<Void>()
    
    func transform(_ input: Input) -> Output {
        input.passwordRecoveryTap.asObservable()
            .subscribe(onNext: { [self] in
                passwordRecoveryTap.onNext($0)
            }).disposed(by: bag)
        
        input.signUpTapDriver.asObservable()
            .subscribe(onNext: { [self] in
                signUpTapPublishSubject.onNext($0)
            }).disposed(by: bag)
        
        let isButtonEnabled = Driver
            .combineLatest(input.emailTextDriver,
                           input.passwordTextDriver)
            
            .map { (username, password) -> Bool in
                if ValidateParameters.isEmailValid(username) == true &&
                    ValidateParameters.isPasswordValid(password) == true {
                    return true
                } else {
                    return false
                }
            }
            .startWith(false)
        
        return Output(isButtonEnabled: isButtonEnabled)
    }
}

extension LoginViewModel {
    struct Input {
        let emailTextDriver: Driver<String>
        let passwordTextDriver: Driver<String>
        let signUpTapDriver: Driver<Void>
        let passwordRecoveryTap: Driver<Void>
    }
    
    struct Output {
        let isButtonEnabled: Driver<Bool>
    }
}

