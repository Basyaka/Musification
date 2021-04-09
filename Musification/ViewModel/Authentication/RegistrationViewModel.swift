//
//  RegistrationViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import RxSwift
import RxCocoa

final class RegistrationViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    let haveAccountTapPublishSubject = PublishSubject<Void>()
    let registrationButtonTapPublishSubject = PublishSubject<Void>()
    
    func transform(_ input: Input) -> Output {
        input.registrationButtonTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                registrationButtonTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        input.haveAccountTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                haveAccountTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        let isButtonEnabled = Driver
            .combineLatest(input.emailTextDriver,
                           input.passwordTextDriver,
                           input.usernameTextDriver)
            
            .map { (email, password, username) -> Bool in
                if ValidateParameters.isEmailValid(email) == true &&
                    ValidateParameters.isPasswordValid(password) == true &&
                    ValidateParameters.isPasswordValid(username) == true {
                    return true
                } else {
                    return false
                }
            }
            .startWith(false)
        
        return Output(isButtonEnabled: isButtonEnabled)
    }
}

extension RegistrationViewModel {
    struct Input {
        let emailTextDriver: Driver<String>
        let passwordTextDriver: Driver<String>
        let usernameTextDriver: Driver<String>
        let haveAccountTapControlEvent: ControlEvent<Void>
        let registrationButtonTapControlEvent: ControlEvent<Void>
    }
    
    struct Output {
        let isButtonEnabled: Driver<Bool>
    }
}
