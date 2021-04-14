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
    
    let getUserInfoReplaySubject = ReplaySubject<UserInfo>.create(bufferSize: 1)
    
    
    func signIn(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                self.successfulEventPublishSubject.onNext(self.event)
            }
        }
    }
    
    func createAccount(email: String, password: String, username: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let uid = result?.user.uid else { return }
            if error != nil {
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                
                let usersReference = self.ref.child("users").child(uid)
                let values = ["email" : email, "username" : username]
                usersReference.updateChildValues(values) { (error, ref) in
                    if error != nil {
                    } else {
                        self.successfulEventPublishSubject.onNext(self.event)
                    }
                }
                
            }
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }

    func getUserInfo() {
        if Auth.auth().currentUser?.uid != nil {
            let uid = Auth.auth().currentUser?.uid
            let userReference = self.ref.child("users").child(uid!)
            userReference.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let username = dictionary["username"] as? String
                    let userInfo = UserInfo(username: username)
                    self.getUserInfoReplaySubject.onNext(userInfo)
                }
                
            }, withCancel: nil)
        }
    }
}
