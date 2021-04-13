//
//  ProfileViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift
import RxCocoa

final class ProfileViewModel: ViewModelType {
    
    private var disposeBag = DisposeBag()
    
    var firebaseService: FirebaseService!
    
    let signOutEventPublishSubject = PublishSubject<Void>()
    
    func transform(_ input: Input) -> Output {
        //Sign Out
        input.confiredSignOutDriver.asObservable()
            .subscribe(onNext: { [self] in
                if firebaseService.signOut() == true {
                    signOutEventPublishSubject.onNext($0)
                }
            }).disposed(by: disposeBag)
        
        //Sign Out Button tap
        let signOutTapControlEvent = input.signOutTapControlEvent
        
        return Output.init(signOutTapControlEvent: signOutTapControlEvent)
    }
}

extension ProfileViewModel {
    struct Input {
        let signOutTapControlEvent: ControlEvent<Void>
        let confiredSignOutDriver: Driver<Void>
    }
    
    struct Output {
        let signOutTapControlEvent: ControlEvent<Void>
    }
}
