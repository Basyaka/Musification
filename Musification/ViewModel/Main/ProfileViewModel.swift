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
    var model: UserInfo!
    
    let signOutEventPublishSubject = PublishSubject<Void>()
    
    let usernameTextReplaySubject = ReplaySubject<String>.create(bufferSize: 1)
    
    func transform(_ input: Input) -> Output {
        //Sign Out
        input.confiredSignOutDriver.asObservable()
            .subscribe(onNext: { [self] in
                if firebaseService.signOut() == true {
                    signOutEventPublishSubject.onNext($0)
                }
            }).disposed(by: disposeBag)

        getUserInfo()
        
        let usernameTextDriver = usernameTextReplaySubject.asDriver(onErrorJustReturn: "")
        
        return Output.init(usernameTextDriver: usernameTextDriver)
    }
    
    //MARK: - Work with User Data
    private func getUserInfo() {
        firebaseService.getUserInfoReplaySubject.subscribe(onNext: { [self] userInfo in
            model = userInfo
            usernameTextReplaySubject.onNext(model.username ?? "Username")
        }).disposed(by: disposeBag)
    }
}

extension ProfileViewModel {
    struct Input {
        let confiredSignOutDriver: Driver<Void>
    }
    
    struct Output {
        let usernameTextDriver: Driver<String>
    }
}
