//
//  PasswordRecoveryViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import RxSwift
import RxCocoa

final class PasswordRecoveryViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    let backTapPublishSubject = PublishSubject<Void>()
    let backSwipePublishSubject = PublishSubject<UISwipeGestureRecognizer>()
    
    func transform(_ input: Input) -> Output {
        input.backTap.asObservable()
            .subscribe(onNext: { [self] in
                backTapPublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        input.backSwipe.asObservable()
            .when(.recognized)
            .subscribe(onNext: { [self] in
                backSwipePublishSubject.onNext($0)
            }).disposed(by: disposeBag)
        
        let isButtonEnabled = Driver
            .asDriver(input.emailTextDriver)()
            .map { (username) -> Bool in
                if ValidateParameters.isEmailValid(username) == true {
                    return true
                } else {
                    return false
                }
            }
            .startWith(false)
        
        return Output(isButtonEnabled: isButtonEnabled)
    }
}

extension PasswordRecoveryViewModel {
    struct Input {
        let emailTextDriver: Driver<String>
        let backTap: Driver<Void>
        let backSwipe: ControlEvent<UISwipeGestureRecognizer>
    }
    
    struct Output {
        let isButtonEnabled: Driver<Bool>
    }
}
