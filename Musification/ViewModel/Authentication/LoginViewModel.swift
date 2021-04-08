//
//  LoginViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    let signUpTapPublishSubject = PublishSubject<Void>()
    let passwordRecoveryTapPublishSubject = PublishSubject<Void>()
    let loginInTapPublishSubject = PublishSubject<Void>()
    
    func transform(_ input: Input) -> Output {
        input.loginButton.asObservable()
            .subscribe(onNext: { [self] in
                loginInTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        input.passwordRecoveryTap.asObservable()
            .subscribe(onNext: { [self] in
                passwordRecoveryTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        input.signUpTapDriver.asObservable()
            .subscribe(onNext: { [self] in
                signUpTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
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
        let signUpTapDriver: ControlEvent<Void>
        let passwordRecoveryTap: ControlEvent<Void>
        let loginButton: ControlEvent<Void>
    }
    
    struct Output {
        let isButtonEnabled: Driver<Bool>
    }
}

