//
//  ProfileViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift
import RxCocoa

final class ProfileViewModel: ViewModelType {
    
//    var didSendEventClosure: ((ProfileViewModel.Event) -> Void)?
    
    private var disposeBag = DisposeBag()
    
    let signOutTapPublishSubject = PublishSubject<Void>()
    
    func transform(_ input: Input) -> Output {
        //Log Out
        input.signOutTapControlEvent.asObservable()
            .subscribe(onNext: { [self] in
                signOutTapPublishSubject.onNext($0)
//                didSendEventClosure?(.profile)
            }).disposed(by: disposeBag)
        
        return Output.init()
    }
}

extension ProfileViewModel {
    struct Input {
        let signOutTapControlEvent: ControlEvent<Void>
    }
    
    struct Output {
        
    }
}


//extension ProfileViewModel {
//    enum Event {
//        case profile
//    }
//}
