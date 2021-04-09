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
    
    var model: FirebaseAuthModel!
    var firebaseService: FirebaseService!
    
    //MARK: - Publish Subject to Coordinator
    let haveAccountTapPublishSubject = PublishSubject<Void>()
    let registrationButtonTapPublishSubject = PublishSubject<Void>()
    
    func transform(_ input: Input) -> Output {
        //Reg event
        input.registrationButtonTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                firebaseService.createAccount(email: model.email!, password: model.password!)
                firebaseResponse()
            }).disposed(by: disposeBag)
        
        //Event for return to login screen
        input.haveAccountTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                haveAccountTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        let isButtonEnabled = Driver
            .combineLatest(input.emailTextDriver,
                           input.passwordTextDriver,
                           input.usernameTextDriver)
            
            .map { (email, password, username) -> Bool in
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
            self.registrationButtonTapPublishSubject.onNext($0)
        }).disposed(by: disposeBag)
        
        //if failure
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
