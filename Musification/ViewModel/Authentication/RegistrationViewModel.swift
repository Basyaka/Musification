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
    
    //MARK: - Publish Relay to View Controller
    private let successRegistrationResponsePublishRelay = PublishRelay<Void>()
    private let failureRegistrationResponsePublishRelay = PublishRelay<Void>()
    
    func transform(_ input: Input) -> Output {
        //Reg event
        input.registrationButtonTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                firebaseService.createAccount(email: model.email!, password: model.password!, username: model.username!)
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
                    ValidateParameters.isPasswordValid(password) == true &&
                    ValidateParameters.isUsernameValid(username) == true {
                    
                    //transfer textfileds text to model
                    self.model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.model.password = password
                    self.model.username = username.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    return true
                } else {
                    return false
                }
            }
            .startWith(false)
        
        //firebase response to VC
        let successRegistrationResponseObservable = successRegistrationResponsePublishRelay.asObservable()
        let failureRegistrationResponseObservable = failureRegistrationResponsePublishRelay.asObservable()
        
        return Output(isButtonEnabled: isButtonEnabled,
                      successRegistrationResponseObservable: successRegistrationResponseObservable,
                      failureRegistrationResponseObservable: failureRegistrationResponseObservable)
    }
    
    //MARK: - Firebase response logic
    private func firebaseResponse() {
        //if success
        firebaseService.successfulEventPublishSubject.subscribe(onNext: {
            //Event to coordinator
            self.registrationButtonTapPublishSubject.onNext($0)
            //Event to VC
            self.successRegistrationResponsePublishRelay.accept($0)
        }).disposed(by: disposeBag)
        
        //if failure
        firebaseService.failureEventPublishSubject.subscribe(onNext: {
            //Event to VC
            self.failureRegistrationResponsePublishRelay.accept($0)
        }).disposed(by: disposeBag)
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
        let successRegistrationResponseObservable: Observable<Void>
        let failureRegistrationResponseObservable: Observable<Void>
    }
}
