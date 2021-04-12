//
//  FirebaseService.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import Firebase
import RxSwift

class FirebaseService {
    
    private let ref = Database.database().reference(fromURL: "https://musification-85862-default-rtdb.firebaseio.com/")
    
    let successfulEventPublishSubject = PublishSubject<Void>()
    let failureEventPublishSubject = PublishSubject<Void>()
    
    private let event: () = PublishSubject<Void>.Element()
    
    func signIn(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                print("LogIn")
                self.successfulEventPublishSubject.onNext(self.event)
            }
        }
    }
    
    func createAccount(email: String, password: String, username: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let uid = result?.user.uid else { return }
            if error != nil {
                print(error!.localizedDescription)
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                let usersReference = self.ref.child("users").child(uid)
                let values = ["email" : email, "username" : username]
                usersReference.updateChildValues(values) { (error, ref) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        print("Saved user info successfully")
                    }
                }
                self.successfulEventPublishSubject.onNext(self.event)
            }
        }
    }
}
