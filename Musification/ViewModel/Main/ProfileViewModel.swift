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
    
    //Sign out to coordinator
    let signOutEventPublishSubject = PublishSubject<Void>()
    
    //User info to view controller
    private let usernameTextReplaySubject = ReplaySubject<String>.create(bufferSize: 1)
    private let userPhotoPublishSubject = PublishSubject<UIImage>()
    
    //Request handler
    private let endUserInfoReqestPublishSubject = PublishSubject<Void>()
    
    private let publishEvent: () = PublishRelay<Void>.Element()
    
    func transform(_ input: Input) -> Output {
        //Sign Out
        input.confiredSignOutDriver.asObservable()
            .subscribe(onNext: { [self] in
                if firebaseService.signOut() == true {
                    signOutEventPublishSubject.onNext($0)
                }
            }).disposed(by: disposeBag)

        getUserInfo()
        
        //User Info data
        let usernameTextDriver = usernameTextReplaySubject.asDriver(onErrorJustReturn: "")
        let userPhotoDriver = userPhotoPublishSubject.asDriver(onErrorJustReturn: UIImage())
        
        //User Info Request Logic
        let endUserInfoRequestObservable = endUserInfoReqestPublishSubject.asObservable()
        
        return Output(usernameTextDriver: usernameTextDriver,
                      userPhotoDriver: userPhotoDriver,
                      endUserInfoRequestObservable: endUserInfoRequestObservable)
    }
    
    //MARK: - Work with User Data
    private func getUserInfo() {
        //Username
        firebaseService.getUsernameReplaySubject.subscribe(onNext: { username in
            self.usernameTextReplaySubject.onNext(username)
        }).disposed(by: disposeBag)
        
        //User Photo
        firebaseService.getUserPhotoPublishSubject.subscribe(onNext: { userPhoto in
            self.userPhotoPublishSubject.onNext(userPhoto)
            self.endUserInfoReqestPublishSubject.onNext(self.publishEvent)
        }).disposed(by: disposeBag)
    }
}

extension ProfileViewModel {
    struct Input {
        let confiredSignOutDriver: Driver<Void>
    }
    
    struct Output {
        let usernameTextDriver: Driver<String>
        let userPhotoDriver: Driver<UIImage>
        let endUserInfoRequestObservable: Observable<Void>
    }
}
