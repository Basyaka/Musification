//
//  FirebaseService.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import Firebase
import RxSwift
import RxCocoa

class FirebaseService {
    
    private let databaseRef = Database.database().reference(fromURL: "https://musification-85862-default-rtdb.firebaseio.com/")
    
    //Error Handler
    let successfulEventPublishSubject = PublishSubject<Void>()
    let failureEventPublishSubject = PublishSubject<Void>()
    
    //Mb to string?
    private let event: () = PublishSubject<Void>.Element()
    
    //User Info
    let getUsernameReplaySubject = ReplaySubject<String>.create(bufferSize: 1)
    let getUserPhotoPublishSubject = PublishSubject<UIImage>()
    
    //MARK: - Sign In
    func signIn(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                self.successfulEventPublishSubject.onNext(self.event)
            }
        }
    }
    
    //MARK: - Create User
    func createAccount(email: String, password: String, username: String, image: Data) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let uid = result?.user.uid else { return }
            if error != nil {
                //Error
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                self.registerUserIntoStorage(uid: uid, email: email, password: password, username: username, image: image)
            }
        }
    }
    
    //Upload users photo into storage
    private func registerUserIntoStorage(uid: String, email: String, password: String, username: String, image: Data) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("images/\(imageName).png")
        
        //Upload to storage
        storageRef.putData(image, metadata: nil) { (metadata, error) in
            if error != nil {
                //Error
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                storageRef.downloadURL { (url, error) in
                    if error != nil {
                        //Error
                        self.failureEventPublishSubject.onNext(self.event)
                    } else {
                        guard let url = url else { return }
                        let urlString = url.absoluteString
                        let values = ["email" : email, "username" : username, "profileImageUrl" : urlString]
                        //Writing users info to realtime database
                        self.registerUserIntoDatabase(uid: uid, values: values)
                    }
                }
                
            }
        }
    }
    
    //Writing users info into realtime database
    private func registerUserIntoDatabase(uid: String, values: [String : String]) {
        //Upload to realtime database
        let usersReference = self.databaseRef.child("users").child(uid)
        usersReference.updateChildValues(values) { (error, ref) in
            if error != nil {
                //Error
                self.failureEventPublishSubject.onNext(self.event)
            } else {
                self.successfulEventPublishSubject.onNext(self.event)
            }
        }
    }
    
    //MARK: - Sign Out Check
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    //MARK: - Get User Info
    func getUserInfo() {
        if Auth.auth().currentUser?.uid != nil {
            let uid = Auth.auth().currentUser?.uid
            let userReference = self.databaseRef.child("users").child(uid!)
            userReference.observeSingleEvent(of: .value, with: { [self] (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let username = dictionary["username"] as? String
                    guard let userPhotoLink = dictionary["profileImageUrl"] as? String else { return }
                    
                    guard let url = URL(string: userPhotoLink) else { return }
                    getUserPhoto(from: url)
                    
                    guard let name = username else { return }
                    self.getUsernameReplaySubject.onNext(name)
                }
            }, withCancel: nil)
        }
    }
    
    private func getUserPhoto(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let photo = UIImage(data: data) {
                    self.getUserPhotoPublishSubject.onNext(photo)
                }
            }
        }
    }
}
