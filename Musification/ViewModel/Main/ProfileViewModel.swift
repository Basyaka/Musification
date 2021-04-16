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
    
    var model: UserInfo!
    var firebaseService: FirebaseService!
    var storageService: UserInfoStorageProtocol!
    
    //Sign out to coordinator
    let signOutEventPublishSubject = PublishSubject<Void>()
    
    //User info to view controller
    private let usernameTextReplaySubject = ReplaySubject<String>.create(bufferSize: 1)
    private let userPhotoReplaySubject = ReplaySubject<UIImage>.create(bufferSize: 1)
    
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
                //Delete user info from database
                self.storageService.deleteUserInfo()
            }).disposed(by: disposeBag)
        
        getUserInfoFromFirebase()
        getUserInfoFromDatabase()
        
        //User Info data
        let usernameTextDriver = usernameTextReplaySubject.asDriver(onErrorJustReturn: "")
        let userPhotoDriver = userPhotoReplaySubject.asDriver(onErrorJustReturn: UIImage())
        
        //User Info Request Logic
        let endUserInfoRequestObservable = endUserInfoReqestPublishSubject.asObservable()
        
        return Output(usernameTextDriver: usernameTextDriver,
                      userPhotoDriver: userPhotoDriver,
                      endUserInfoRequestObservable: endUserInfoRequestObservable)
    }
    
    //MARK: - Work with User Data
    //From Firebase
    private func getUserInfoFromFirebase() {
        //Username
        firebaseService.getUsernameReplaySubject.subscribe(onNext: { username in
            self.model.username = username
            self.usernameTextReplaySubject.onNext(username)
        }).disposed(by: disposeBag)
        
        //User Photo
        firebaseService.getUserPhotoPublishSubject.subscribe(onNext: { [self] userPhoto in
            model.userPhotoData = userPhoto.pngData()
            userPhotoReplaySubject.onNext(userPhoto)
            endUserInfoReqestPublishSubject.onNext(self.publishEvent)
            
            //Save info to database
            storageService.saveUserInfo(model)
        }).disposed(by: disposeBag)
    }
    
    //From Database
    private func getUserInfoFromDatabase() {
        //if userInfo != nil into db
        guard let username = model.username else { return }
        usernameTextReplaySubject.onNext(username)
        guard let data = model.userPhotoData else { return }
        guard let userPhoto = UIImage(data: data) else { return }
        userPhotoReplaySubject.onNext(userPhoto)
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
