//
//  FirebaseService.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import FirebaseAuth
import RxSwift

class FirebaseService {
    
    let successfulEventPublishSubject = PublishSubject<Void>()
    let failureEventPublishSubject = PublishSubject<Void>()
    
    private let event: () = PublishSubject<Void>.Element()
    
    func signIn(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("Error")
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                print("LogIn")
                self.successfulEventPublishSubject.onNext(self.event)
            }
        }
    }
    
    func createAccount(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("Error")
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                print("LogIn")
                self.successfulEventPublishSubject.onNext(self.event)
            }
        }
    }
}
