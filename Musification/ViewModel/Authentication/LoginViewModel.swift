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
    
    var model: FirebaseAuthModel!
    var firebaseService: FirebaseService!
    
    //MARK: - Publish Subject to Coordinator
    let signUpTapPublishSubject = PublishSubject<Void>()
    let passwordRecoveryTapPublishSubject = PublishSubject<Void>()
    let loginInTapPublishSubject = PublishSubject<Void>()
    
    func transform(_ input: Input) -> Output {
        //Event for password recovery screen
        input.passwordRecoveryTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                passwordRecoveryTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        //Event for registration screen
        input.signUpTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                signUpTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        //Login button tap event
        input.loginButtonTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                firebaseService.signIn(email: model.email!, password: model.password!)
                firebaseResponse()
            }).disposed(by: disposeBag)
        
        //Check text fields property and isEnabled login button logic
        let isButtonEnabled = Driver
            .combineLatest(input.emailTextDriver,
                           input.passwordTextDriver)
            
            .map { (email, password) -> Bool in
                if ValidateParameters.isEmailValid(email.trimmingCharacters(in: .whitespacesAndNewlines)) == true &&
                    ValidateParameters.isPasswordValid(password) == true {
                    
                    //transfer textfileds text to model
                    self.model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.model.password = password
                    
                    return true
                } else {
                    return false
                }
            }
            .startWith(false)
        
        return Output(isButtonEnabled: isButtonEnabled)
    }
    
    //MARK: - Firebase response logic
    private func firebaseResponse() {
        //if success
        firebaseService.successfulEventPublishSubject.subscribe(onNext: {
            self.loginInTapPublishSubject.onNext($0)
        }).disposed(by: disposeBag)
        
        //if failure
    }
}

extension LoginViewModel {
    struct Input {
        let emailTextDriver: Driver<String>
        let passwordTextDriver: Driver<String>
        let signUpTapControlEvent: ControlEvent<Void>
        let passwordRecoveryTapControlEvent: ControlEvent<Void>
        let loginButtonTapControlEvent: ControlEvent<Void>
    }
    
    struct Output {
        let isButtonEnabled: Driver<Bool>
    }
}

